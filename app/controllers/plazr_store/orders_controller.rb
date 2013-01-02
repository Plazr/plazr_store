module PlazrStore
  class OrdersController < ApplicationController
    include PaypalExpressHelper
    
    before_filter :get_cart, only: [:new, :create]
    before_filter :get_auxiliar_data, only: [:new, :create]
    before_filter :assigns_gateway, only: [:new, :create]

    def cancel
      @order = Order.find(params[:id])
      # TODO apenas o admin pode fazer isto (talvez staff)
      @order.to_be_cancelled = true

      # flash[:notice] = "Order #{@order.id} set to be cancelled"
      # redirect_to admin_edit_order_path(@order.id)
    end
    
    def new
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
      
      @order = Order.new(
        :express_token => order_address[:gateway_details][:token], 
        :payer_id => order_address[:gateway_details][:payer_id] 
      )
      @order.load_user(current_user)
    end
    
    def create
      ActiveRecord::Base.transaction do # so that order's cart changes aren't presisted if an error occurs
        @order = Order.new(params[:order])
        @order.load_user(current_user)
        @order.add_cart_and_update_status(@cart)
        
        if params[:order][:express_token].nil?
          redirect_to cart_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Please try again later." 
          return
        end

        unless @order.save
          render :new
          return
        end
        
        purchase_params = get_purchase_params request, params
        purchase = @gateway.purchase current_user.cart.total_price, purchase_params

        if purchase.success?
          # you might want to destroy your cart here if you have a shopping cart 
          notice = "Thanks! Your purchase is now complete!"
          # indicates which is the last order when the receipt action is called
          session[:last_order] = @order.id
          # redirects to last_order receipt
          redirect_to receipt_url 
        else
          @order.destroy
          redirect_to cart_url :notice => "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
        end
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
      redirect_to root_url if current_user.nil?
    end

    def receipt
      # redirects to the last order receipt view
      if session.has_key?(:last_order)
        @order = Order.find(session[:last_order])
      else
        redirect_to root_url 
      end
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
