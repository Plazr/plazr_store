module PlazrStore
  class OrdersController < ApplicationController

    before_filter :get_cart, only: [:new, :create]
    before_filter :get_auxiliar_data, only: [:new, :create]

    def create
      @order = Order.new(params[:order])
      @order.load_user(current_user)
      @order.add_cart_and_update_status(@cart)

      if @order.save
        # indicates which is the last order when the receipt action is called
        session[:last_order] = @order.id
        # redirects to last_order receipt
        redirect_to receipt_url
      else
        render :new
      end
    end

    def new
      @order = Order.new
      @order.load_user(current_user)
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
        @cart = Cart.new#current_user.cart
      end
  end
end
