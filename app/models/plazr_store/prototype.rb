module PlazrStore
  class Prototype < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :products
    has_and_belongs_to_many :properties
    has_and_belongs_to_many :variant_properties

    ## Attributes ##
    attr_accessible :name

    # Validations
    validates :name, presence: true
  end
end
