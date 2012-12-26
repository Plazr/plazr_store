module PlazrStore
  class OrdersController < ApplicationController

    before_filter :get_cart, only: [:new, :create]
    before_filter :get_auxiliar_data, only: [:new, :create]

    def create
      @order = Order.new(params[:order])
      @order.load_user(current_user)
      # TODO aqui ou atribui um cart a order ou faz uma copia de cada CartVariant para uma nova relacao OrderVariant
      # @order.cart

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
      @cart = Cart.new
    end

    def receipt
      if !session.has_key?(:last_order)
        redirect_to root_url 
        return
      end

      @order = Order.find(session[:last_order])
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
