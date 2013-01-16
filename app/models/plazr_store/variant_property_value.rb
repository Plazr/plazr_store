module PlazrStore
  # Class representing a value for a variant property
  class VariantPropertyValue < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    belongs_to :variant_property

    has_many :variant_variant_property_values, :dependent => :destroy
    has_many :variants, :through => :variant_variant_property_values

    ## Attributes ##
    attr_accessible :name, :presentation, :variant_property_id

    ##Validations ##
    validates_presence_of :name, :variant_property
    validates :name, :uniqueness_without_deleted => true
    validates :variant_property, :presence => true

    ## Callbacks ##
    before_save :fill_fields

    # Fill the presentation name with the value name
    def fill_fields
      self.presentation = self.name unless !self.presentation.blank?
    end
  end
end
