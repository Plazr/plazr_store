module PlazrStore
  # Class representing a wishlist for an user on a store
  class Wishlist < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    has_many :variant_wishlists
    has_many :variants, :through => :variant_wishlists

    ## Attributes ##
    attr_accessible :is_private, :name, :user_id

    ## Validations ##
    validates :user_id, presence: true

    ## Instance Methods ##
    
    # Add an item (product variant) to the wishlist
    def add(variant)
      wishlist_variant = self.variant_wishlists.find_or_create_by_variant_id(variant.id)
    end

    # Remove an item (product variant) to the wishlist
    def remove(variant)
      self.variant_wishlists.find_by_variant_id(variant.id).destroy
    end

    # Get the user associated with this wishlist
    def user
      PlazrAuth::User.find(user_id)
    end

  end
end
