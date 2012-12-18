module PlazrStore
  class ProductProperty < ActiveRecord::Base
    ## Relations ##
    belongs_to :product
    belongs_to :property

    ## Attributes ##
    attr_accessible :value, :product_id, :property_id, :property, :product
  end
end
