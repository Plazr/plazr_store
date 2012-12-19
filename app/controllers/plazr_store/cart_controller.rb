module PlazrStore
  class CartController < ApplicationController

    before_filter :get_cart
    before_filter :get_fields, except: [ :show ]

    def show

    end

    # POST /cart/add/:variant_id
    def add
      render text: current_user.to_s
      #current_user.carts
      #render text: 'yay'
    end

    # DELETE /cart/remove/:variant_id
    def remove
      render text: 'yay'
    end


    protected

      def get_cart
        @cart = current_user.cart
      end

      def get_fields
        @variant = Variant.find params[:variant_id]
        @amount  = params[:amount]
      end

  end
end
