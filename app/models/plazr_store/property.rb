module PlazrStore
  class Property < ActiveRecord::Base
    ## Relations ##
    has_and_belongs_to_many :prototypes

    has_many :product_properties
    has_many :products, :through => :product_properties

    ## Attributes ##
    attr_accessible :display_name, :id_name
  end
end
