module PlazrStore
  class Product < ActiveRecord::Base
    ## Relations ##
    belongs_to :brand
    belongs_to :prototype

    has_many :feedback_products

    has_many :product_properties
    has_many :properties, :through => :product_properties
    
    #has_and_belongs_to_many :variant_properties
    has_many :product_variant_properties
    has_many :variant_properties, :through => :product_variant_properties

    ## Attributes ##
    attr_accessible :available_at, :details, :name, :permalink, :price_max, :price_min, :rating
  end
end
