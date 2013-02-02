module PlazrStore
  class OrdersController < ApplicationController
    include PaypalExpressHelper

    before_filter :get_cart, only: [:new, :create, :review]
    before_filter :get_auxiliar_data, only: [:new, :create, :review]
    before_filter :assigns_gateway, only: [:create, :review]

    # def cancel
    #   @order = Order.find(params[:id])
    #   # TODO apenas o admin pode fazer isto (talvez staff)
    #   @order.to_be_cancelled = true
    #   # flash[:notice] = "Order #{@order.id} set to be cancelled"
    #   # redirect_to admin_edit_order_path(@order.id)
    # end
    def new
      @order = Order.new
      @order.load_user(current_user)        

      authorize! :create, @order
    end

    def review
      if params[:token].nil? | session[:shipment_condition_id].nil?
        redirect_to cart_path, :notice => 'Woops! You\'ve accessed an invalid page!' 
        return
      end

      gateway_response = @gateway.details_for(params[:token])

      unless gateway_response.success?
        redirect_to cart_url, 
          :notice => "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}" and return
      end
    
      order_address = get_order_info gateway_response
      @address = Address.new(order_address[:address])

      @order = Order.new(
        :express_token => params['token'], 
        :payer_id => params['PayerID']
      )
      
      @order.load_user(current_user)
      #set shipment condition and calculate total
      @order.load_pre_order_info(current_user, session[:shipment_condition_id])
    end

    def create
      @order = Order.new(params[:order])
      #user has accessed the review page without getting the paypall authorization 
      unless @order.paypal.nil?
        redirect_to cart_url and return if session[:shipment_condition_id].nil?
      end
      
      ActiveRecord::Base.transaction do # so that order's cart changes aren't presisted if an error occurs
        
        @order.load_user(current_user)
        @order.add_cart_and_update_status(@cart)

        authorize! :create, @order

        if params['payment_method']['name'] == "Paypal" 
          #when we are redirected from paypal we should have the shipment condition in the session hash
          #@order.paypal is a hiden field to test if the purshase was completed. If it was interrupted we need to create restart the session variables
          unless (session[:shipment_condition_id].nil? | @order.paypal.nil?)
            #validating that a token was returned from paypal
            if @order.express_token.blank?
              redirect_to cart_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Please try again later." and return
            end
            @order.shipment_condition_id = session[:shipment_condition_id]
          else  
            @pre_order = PreOrder.new(:shipment_condition_id => params[:order][:shipment_condition_id])
            #validating the existance of the shipment_condition before redirect to paypal
            if @pre_order.valid?
              session[:shipment_condition_id] = params[:order][:shipment_condition_id]
              redirect_to :controller => 'paypal_express', :action => 'checkout' and return
            else 
              render 'new' and return
            end
          end
        end
        
          # paypal is ok
        if @order.save
          @order.update_attributes(:total => current_user.cart.total_price + ShipmentCondition.find(@order.shipment_condition_id).price)
          # paypal method: executes purchase
          if params['payment_method']['name'] == "Paypal" 
            # changes order's payment_state to "paid"
            # @order.update_attributes(:payment_state => "paid")
            # total: total to be paid
            # purchase_params: paypal account details
            total, purchase_params = get_purchase_params request, params
            # paypal purchase
            purchase = @gateway.purchase total, purchase_params

            if purchase.success?
              notice = "Thanks! Your purchase is now complete!"
              session[:shipment_condition_id] = nil
            else
              @order.destroy
              redirect_to cart_url :notice => "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}" and return
            end
          end

          # marks the cart as deleted 
          PZS::Cart.find(@order.cart.id).delete
          # indicates which is the last order when the receipt action is called
          session[:last_order] = @order.id
          # redirects to last_order receipt
          redirect_to receipt_url and return
        else
          if params['payment_method']['name'] == "Paypal"   
            render 'review' and return
          else 
            render 'new' and return
          end
        end
      end
    end
    

    def get_purchase_params(request, params)
      return to_cents(@order.total), {
        :ip => request.remote_ip,
        :token => params[:order][:express_token],
        :payer_id => params[:order][:payer_id],
        :currency => 'EUR'
      }
    end

    def history
      authorize! :index, Order
      @orders = current_user.orders.paginate(:per_page => 5, :page => params[:page])
    end

    def receipt
      # redirects to the last order receipt view
      if session.has_key?(:last_order)
        @order = Order.find(session[:last_order])
        authorize! :read, @order, :message => "You are not authorized to see the receipt of this order!"
      else
        redirect_to plazr_auth_url 
      end
    end

    def show
      @order = Order.find(params[:id])
      begin
        authorize! :show, @order, :message => "You are not authorized to see this order!"
      rescue CanCan::AccessDenied => exception
        redirect_to orders_history_url, :alert => exception.message
      end
    end

    protected
    def check_authorization
      authorize! :access, :orders_actions
    end

    def get_auxiliar_data
      @shipment_conditions = ShipmentCondition.all
    end

    def get_cart
      @cart = current_user.cart
    end
  end
end
