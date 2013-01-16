module PlazrStore
  # Class representing a product property
  # It has a property and the respective value
  class ProductProperty < ActiveRecord::Base
    ## Relations ##
    belongs_to :product
    belongs_to :property

    ## Attributes ##
    attr_accessible :value, :product_id, :property_id, :property, :product

    ## Validations ##
    validates :value, :presence => true

    ## Callback ##
    before_validation :unique_product_property

    # Check if this property is only associated once with the same product
    def unique_product_property
      ProductProperty.find_by_product_id_and_property_id(self.product_id, self.property_id).nil?
    end
  end
end
