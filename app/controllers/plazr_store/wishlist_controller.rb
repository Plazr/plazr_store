module PlazrStore
  class WishlistController < ApplicationController

    before_filter :check_authorization
    before_filter :get_wishlist
    before_filter :get_fields, except: [ :show ]

    def show
    end

    # POST /wishlist/add/:variant_id
    def add
      ActiveRecord::Base.transaction do # so that cart and cart_variant updates are atomically saved
        @wishlist.add(@variant)
      end
      redirect_to :back
    end

    # DELETE /wishlist/remove/:variant_id
    def remove
      @wishlist.remove(@variant)
      redirect_to :back
    end


    protected

      def check_authorization
        authorize! :access, :wishlist_actions
      end

      def get_wishlist
        @wishlist = current_user.wishlist
      end

      def get_fields
        @variant = Variant.find params[:id]
      end

  end
end
