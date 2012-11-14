module PlazrStore
  class Property < ActiveRecord::Base
    ## Relations ##
    has_and_belongs_to_many :prototypes

    has_many :product_properties
    has_many :products, :through => :product_properties

    ## Attributes ##
    attr_accessible :name_display, :name_id
  end
end
