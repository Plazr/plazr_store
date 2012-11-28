module PlazrStore
  class Prototype < ActiveRecord::Base
    ## Relations ##
    has_many :product
    #has_and_belongs_to_many :properties
    has_many :property_prototypes
    has_many :properties, :through => :property_prototypes

    #has_and_belongs_to_many :variant_properties
    has_many :prototype_variant_properties
    has_many :variant_properties, :through => :prototype_variant_properties

    ## Attributes ##
    attr_accessible :name
  end
end
