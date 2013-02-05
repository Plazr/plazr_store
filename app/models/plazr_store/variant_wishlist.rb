# encoding: utf-8
module PlazrStore
  class VariantWishlist < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :wishlist
    
    ## Attributes ##
    attr_accessible :variant_id, :wishlist_id

    ## Delegations
    delegate :info, :to => :variant
    delegate :name, :to => :variant
    delegate :product, :to => :variant
  end
end
