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
    end
    
    def review
      if params[:token].nil?
       redirect_to cart_path, :notice => 'Woops! Something went wrong!' 
       return
      end

      gateway_response = @gateway.details_for(params[:token])

      unless gateway_response.success?
       redirect_to cart_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}" 
       return
      end

      order_address = get_order_info gateway_response
      @address = Address.new(order_address[:address])
      total = ShipmentCondition.find(session[:shipment_condition]).price + @cart.total_price

      @order = Order.new(
       :express_token => order_address[:gateway_details][:token], 
       :payer_id => order_address[:gateway_details][:payer_id],
       :shipment_condition_id => session[:shipment_condition],
       :total => total
      )
      @order.load_user(current_user)
    end
    
    def create
      @order = Order.new(params[:order])
            
      if @order.express_token == ""
        if params[:order][:shipment_condition_id].nil?
          flash[:notice] = "Need to specify a Shipment Condition"
          render 'new'
          return 
        end
        if params['payment_method']['name'] == "Paypal" 
          session[:shipment_condition] = params[:order][:shipment_condition_id]
          redirect_to :controller => 'paypal_express', :action => 'checkout'
          return
        else 
          shipment_price = ShipmentCondition.find(params[:order][:shipment_condition_id]).price
        end
      else 
        if defined? session[:shipment_condition]
          @order.shipment_condition_id = session[:shipment_condition]
        end
        shipment_price = ShipmentCondition.find(@order.shipment_condition_id).price
      end
      
      ActiveRecord::Base.transaction do # so that order's cart changes aren't presisted if an error occurs
        @order.load_user(current_user)
        @order.add_cart_and_update_status(@cart)
        @order.total = current_user.cart.total_price + shipment_price
        
        if @order.express_token.nil?
          redirect_to cart_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Please try again later." 
          return
        end
        
        purchase_params = get_purchase_params request, params
        purchase = @gateway.purchase @order.total, purchase_params

        #if purchase.success?
          # you might want to destroy your cart here if you have a shopping cart 
        #  notice = "Thanks! Your purchase is now complete!"
        #else
        #  @order.destroy
        #  redirect_to cart_url :notice => "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
        #end



        if @order.save
          # marks the cart as deleted 
          PZS::Cart.find(@order.cart.id).delete
          # indicates which is the last order when the receipt action is called
          session[:last_order] = @order.id
          session[:shipment_condition] = nil
          # redirects to last_order receipt
          redirect_to receipt_url
          return 
        else
          if params['payment_method']['name'] == "Paypal"   
            render 'review'
            return
          else 
            render 'new'
            return
          end
        end

        render receipt
      end
    end
    
    def get_purchase_params(request, params)
      {
        :ip => request.remote_ip,
        :token => params[:order][:express_token],
        :payer_id => params[:order][:payer_id]
      }
    end
        
    def history
      redirect_to plazr_auth_url if current_user.nil?
    end

    def receipt
      # redirects to the last order receipt view
      if session.has_key?(:last_order)
        @order = Order.find(session[:last_order])
      else
        redirect_to plazr_auth_url 
      end
    end
    
    def confirm
      #if params[:token].nil?
      #  redirect_to cart_path, :notice => 'Woops! Something went wrong!' 
      #  return
      #end
      
      #gateway_response = @gateway.details_for(params[:token])

      #unless gateway_response.success?
      #  redirect_to cart_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}" 
      #  return
      #end
      
      #order_address = get_order_info gateway_response
      #@address = Address.new(order_address[:address])
    end
    
    protected
      def get_auxiliar_data
        @shipment_conditions = ShipmentCondition.all
      end

      def get_cart
        @cart = current_user.cart
      end
  end
end
