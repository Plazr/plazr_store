module PlazrStore
  class Property < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    ## Relations ##
    has_and_belongs_to_many :prototypes

    has_many :product_properties
    has_many :products, :through => :product_properties

    ## Attributes ##
    attr_accessible :display_name, :id_name

    validates :display_name, presence: true
  end
end
