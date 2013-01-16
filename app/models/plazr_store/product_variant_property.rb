module PlazrStore
  # Class representing a property for a product's variant
  class ProductVariantProperty < ActiveRecord::Base
    ## Relations ##
    belongs_to :product
    belongs_to :variant_property
    
    ## Attributes ##
    attr_accessible :product_id, :variant_property_id, :variant_property

    ## Callback ##
    before_validation :unique_product_variant_property

    # Check if this property is only associated once with the same product variant
    def unique_product_variant_property
      ProductVariantProperty.find_by_product_id_and_variant_property_id(self.product_id, self.variant_property_id).nil?
    end
  end
end
