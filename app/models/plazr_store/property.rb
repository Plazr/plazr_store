# encoding: utf-8
module PlazrStore
  class Property < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :product_properties, :dependent => :destroy
    has_many :products, :through => :product_properties

    has_many :property_prototypes, :dependent => :destroy
    has_many :prototypes, :through => :property_prototypes

    #Nested Attributes
    accepts_nested_attributes_for :product_properties

    ## Attributes ##
    attr_accessible :display_name, :id_name, :product_properties_attributes

    ## Validations ##
    validates :id_name, presence: true, :uniqueness_without_deleted => true

    ## Callbacks ##
    before_save :fill_fields

    def fill_fields
      self.display_name = self.id_name unless !self.display_name.blank?
    end
  end
end
