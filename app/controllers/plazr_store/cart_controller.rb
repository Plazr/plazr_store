module PlazrStore
  # Controller for interacting with the cart model
  class CartController < ApplicationController

    before_filter :check_authorization
    before_filter :get_cart
    before_filter :get_fields, except: [ :show ]

    def show
    end

    # POST /cart/add/:variant_id

    # Add a given amount of a product variant to the shopping cart of the current user
    def add
      ActiveRecord::Base.transaction do # so that cart and cart_variant updates are atomically saved
        current_user.cart.add(@variant, @amount)
      end
      redirect_to :back
    end

    # DELETE /cart/remove/:variant_id

    # Remove a given product variant from the shopping cart of the current user
    def remove
      current_user.cart.remove(@variant)#, @amount)
      redirect_to :back
    end


    protected

      # Check the permissions to interact with the shopping cart of the current user
      def check_authorization
        authorize! :access, :cart_actions
      end

      # Get the shopping cart of the current user (it may exist from previous visits to the store)
      def get_cart
        @cart = current_user.cart
        authorize! :manage, @cart
      end

      # Get the product variant and amount to add to the shopping cart
      def get_fields
        @variant = Variant.find params[:id]
        @amount  = params[:amount].to_i || 1
      end

  end
end
