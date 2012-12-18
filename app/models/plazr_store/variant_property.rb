module PlazrStore
  class VariantProperty < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :product_variant_properties
    has_many :products, :through => :product_variant_properties

    has_many :prototype_variant_properties
    has_many :prototypes, :through => :prototype_variant_properties

    has_many :variant_property_values, :dependent => :destroy

    ## Attributes ##
    attr_accessible :display_name, :id_name

    ## Validations ##
    validates :display_name, :presence => true
    validates :id_name, :uniqueness_without_deleted => true
  end
end
