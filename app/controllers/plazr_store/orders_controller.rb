module PlazrStore
  class OrdersController < ApplicationController

    before_filter :get_cart, only: [:new, :create]
    before_filter :get_auxiliar_data, only: [:new, :create]

    def new
      @order = Order.new
      @order.load_user(current_user)
    end

    def create
      @order = Order.new(params[:order])
      @order.load_user(current_user)
      # TODO aqui ou atribui um cart a order ou faz uma copia de cada CartVariant para uma nova relacao OrderVariant
      # @order.cart

      if @order.save
        #TODO redirecionar para uma especie de recibo
      else
        render :new
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
