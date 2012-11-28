module PlazrStore
  class VariantWishlist < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :wishlist
    
    ## Attributes ##
    attr_accessible :variant_id, :wishlist_id
  end
end