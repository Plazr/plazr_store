module PlazrStore
  # Class representing a prototype from which product inherit
  class Prototype < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :property_prototypes, :dependent => :destroy
    has_many :properties, :through => :property_prototypes

    has_many :prototype_variant_properties, :dependent => :destroy
    has_many :variant_properties, :through => :prototype_variant_properties

    # Nested Attributes
    accepts_nested_attributes_for :property_prototypes, :allow_destroy => true
    accepts_nested_attributes_for :prototype_variant_properties, :allow_destroy => true

    ## Attributes ##
    attr_accessible :name, :property_prototypes_attributes, 
                    :prototype_variant_properties_attributes

    # Validations
    validates :name, presence: true, :uniqueness_without_deleted => true

    # Get an array for all prototypes properties that not associated with the current prototype and builds them in the prototype
    def get_unselected_properties_and_order_by_name
      (Property.all - self.properties).each do |p|
        self.property_prototypes.build(:property => p) unless self.property_prototypes.map(&:property_id).include?(p.id)
      end
      # to ensure that all properties are always shown in a consistent order
      self.property_prototypes.sort_by! {|x| x.property.display_name}
    end

    # Get an array for all properties of the prototype variants that not associated with the current prototype and builds them in the prototype
    def get_unselected_variant_properties_and_order_by_name
      (VariantProperty.all - self.variant_properties).each do |vp|
        self.prototype_variant_properties.build(:variant_property => vp) unless self.prototype_variant_properties.map(&:variant_property_id).include?(vp.id)
      end
      # to ensure that all variant_properties are always shown in a consistent order
      self.prototype_variant_properties.sort_by! {|x| x.variant_property.display_name}
    end
  end
end
