module PlazrStore
  class CartController < ApplicationController

    before_filter :check_authorization
    before_filter :get_cart
    before_filter :get_fields, except: [ :show ]

    def show
    end

    # POST /cart/add/:variant_id
    def add
      ActiveRecord::Base.transaction do # so that cart and cart_variant updates are atomically saved
        current_user.cart.add(@variant, @amount)
      end
      redirect_to :back
    end

    # DELETE /cart/remove/:variant_id
    def remove
      current_user.cart.remove(@variant)#, @amount)
      redirect_to :back
    end


    protected

      def check_authorization
        authorize! :access, :cart_actions
      end

      def get_cart
        @cart = current_user.cart
      end

      def get_fields
        @variant = Variant.find params[:id]
        @amount  = params[:amount].to_i || 1
      end

  end
end
