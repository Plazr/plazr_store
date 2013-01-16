module PlazrStore
  # Class for associating multiple variants with properties and values
  class VariantVariantPropertyValue < ActiveRecord::Base
    
    ## Relations ##
    belongs_to :variant
    belongs_to :variant_property_value

    ## Atributes ##
    attr_accessible :variant_id, :variant_property_value_id, :variant_property_value
  end
end
