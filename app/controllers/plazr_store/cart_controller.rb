module PlazrStore
  class CartController < ApplicationController

    before_filter :get_cart
    before_filter :get_fields, except: [ :show ]

    def show
    end

    # POST /cart/add/:variant_id
    def add
      current_user.cart.add(@variant, @amount)
      redirect_to :back
    end

    # DELETE /cart/remove/:variant_id
    def remove
      current_user.cart.remove(@variant)#, @amount)
      redirect_to :back
    end


    protected

      def get_cart
        @cart = current_user.cart
      end

      def get_fields
        @variant = Variant.find params[:id]
        @amount  = params[:amount].to_i || 1
      end

  end
end
