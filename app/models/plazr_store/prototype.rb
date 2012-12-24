module PlazrStore
  class Prototype < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :property_prototypes
    has_many :properties, :through => :property_prototypes

    has_many :prototype_variant_properties
    has_many :variant_properties, :through => :prototype_variant_properties

    # Nested Attributes
    accepts_nested_attributes_for :property_prototypes, :allow_destroy => true
    accepts_nested_attributes_for :prototype_variant_properties, :allow_destroy => true

    ## Attributes ##
    attr_accessible :name, :property_prototypes_attributes, 
                    :prototype_variant_properties_attributes

    # Validations
    validates :name, presence: true, :uniqueness_without_deleted => true

    def get_unselected_properties_and_order_by_name
      # creates an array for all property_prototypes that the prototype does not currently have selected
      # and builds them in the prototype
      (Property.all - self.properties).each do |p|
        self.property_prototypes.build(:property => p) unless self.property_prototypes.map(&:property_id).include?(p.id)
      end
      # to ensure that all properties are always shown in a consistent order
      self.property_prototypes.sort_by! {|x| x.property.display_name}
    end

    def get_unselected_variant_properties_and_order_by_name
      # creates an array for all prototype_variant_properties that the prototype does not currently have selected
      # and builds them in the prototype
      (VariantProperty.all - self.variant_properties).each do |vp|
        self.prototype_variant_properties.build(:variant_property => vp) unless self.prototype_variant_properties.map(&:variant_property_id).include?(vp.id)
      end
      # to ensure that all variant_properties are always shown in a consistent order
      self.prototype_variant_properties.sort_by! {|x| x.variant_property.display_name}
    end
  end
end
