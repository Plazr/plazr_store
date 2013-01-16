module PlazrStore
  # Controller for interacting with the wishlist model
  class WishlistController < ApplicationController

    before_filter :check_authorization
    before_filter :get_wishlist
    before_filter :get_fields, except: [ :show ]

    def show
    end

    # POST /wishlist/add/:variant_id

    # Add a product variant, chosen from the view, to the wishlist
    def add
      ActiveRecord::Base.transaction do # so that cart and cart_variant updates are atomically saved
        @wishlist.add(@variant)
      end
      redirect_to :back
    end

    # DELETE /wishlist/remove/:variant_id

    # Remove a product variant, chosen from the view, from the wishlist
    def remove
      @wishlist.remove(@variant)
      redirect_to :back
    end


    protected

      # Check the authorization of the user to interact with the wishlist
      def check_authorization
        authorize! :access, :wishlist_actions
      end

      # Get the wishlist from the current user and authorizes him to manage it
      def get_wishlist
        @wishlist = current_user.wishlist
        authorize! :manage, @wishlist
      end

      # Get the product variant information
      def get_fields
        @variant = Variant.find params[:id]
      end

  end
end
