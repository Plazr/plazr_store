module PlazrStore
  module WishlistHelper

    def add_to_wishlist_form(variant_id)
      form_tag wishlist_add_path(variant_id), :id => "add_wishlist_f",method: :post do
      	
      end
    end

  end
end
