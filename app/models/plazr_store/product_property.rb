# encoding: utf-8
module PlazrStore
  class ProductProperty < ActiveRecord::Base
    ## Relations ##
    belongs_to :product
    belongs_to :property

    ## Attributes ##
    attr_accessible :value, :product_id, :property_id, :property, :product

    ## Validations ##
    validates :value, :presence => true

    ## Callback ##
    before_validation :unique_product_property, :on => :create

    def unique_product_property
      ProductProperty.find_by_product_id_and_property_id(self.product_id, self.property_id).nil?
    end
  end
end
