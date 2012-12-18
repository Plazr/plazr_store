module PlazrStore
  class Prototype < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :products

    has_many :property_prototypes
    has_many :properties, :through => :property_prototypes

    has_many :prototype_variant_properties
    has_many :variant_properties, :through => :prototype_variant_properties

    ## Attributes ##
    attr_accessible :name, :property_ids, :variant_property_ids

    # Validations
    validates :name, presence: true
  end
end
