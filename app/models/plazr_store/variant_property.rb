module PlazrStore
  class VariantProperty < ActiveRecord::Base
    ## Relations ##
    has_and_belongs_to_many :products
    has_and_belongs_to_many :prototypes

    has_many :variant_property_values
    has_many :variants, :through => :variant_property_values

    ## Attributes ##
    attr_accessible :name_display, :name_id
  end
end
