module PlazrStore
  class VariantPropertyValue < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :variant_property

    ## Attributes ##
    attr_accessible :value, :variant_id, :variant_property_id, :variant, :variant_property
  end
end
