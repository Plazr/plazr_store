module PlazrStore
  class OrdersController < ApplicationController

    # before_filter :get_cart, only: [:new]
    # before_filter :get_fields, except: [ :show ]
    before_filter :get_auxiliar_data, only: [:new]

    def new
      @order = Order.new
    end

    # POST /cart/add/:variant_id
    # def add
    #   amount = params[:amount] || 1
    #   current_user.cart.add(@variant, amount)
    #   redirect_to :back
    # end

    # # DELETE /cart/remove/:variant_id
    # def remove
    #   current_user.cart.remove(@variant)
    #   redirect_to :back
    # end


    protected
      def get_auxiliar_data
        @shipment_conditions = ShipmentCondition.all
      end

      def get_cart
        @cart = current_user.cart
      end

      # def get_fields
      #   @variant = Variant.find params[:id]
      #   @amount  = params[:amount]
      # end
  end
end
