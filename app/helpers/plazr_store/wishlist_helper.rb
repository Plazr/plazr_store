module PlazrStore
  module WishlistHelper

  	# Helper method to add a product variant to the wishlist from a view form
    def add_to_wishlist_form(variant_id)
      form_tag wishlist_add_path(variant_id), method: :post do
        submit_tag('Add to Wishlist')
      end
    end

  end
end
