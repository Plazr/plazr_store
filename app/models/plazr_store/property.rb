module PlazrStore
  class Property < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :product_properties
    has_many :products, :through => :product_properties

    has_many :property_prototypes
    has_many :prototypes, :through => :property_prototypes

    ## Attributes ##
    attr_accessible :display_name, :id_name

    ## Validations ##
    validates :display_name, presence: true
    validates :id_name, :uniqueness_without_deleted => true
  end
end
