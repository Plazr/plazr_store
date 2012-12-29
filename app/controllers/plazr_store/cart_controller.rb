module PlazrStore
  class CartController < ApplicationController

    before_filter :get_cart
    before_filter :get_fields, except: [ :show ]

    def show
    end

    # POST /cart/add/:variant_id
    def add
      ActiveRecord::Base.transaction do # so that cart and cart_variant updates are atomically saved
        current_user.cart.add(@variant, @amount)
        current_user.update_total_price
      end
      redirect_to :back
    end

    # DELETE /cart/remove/:variant_id
    def remove
      @cart.remove(@variant)#, @amount)
      @cart.update_total_price
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
