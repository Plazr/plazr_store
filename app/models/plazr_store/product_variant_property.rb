module PlazrStore
  class ProductVariantProperty < ActiveRecord::Base
    ## Relations ##
    belongs_to :product
    belongs_to :variant_property
    
    ## Attributes ##
    attr_accessible :product_id, :variant_property_id
  end
end