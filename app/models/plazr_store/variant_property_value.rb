module PlazrStore
  class VariantPropertyValue < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :variant_property

    ## Attributes ##
    attr_accessible :value
  end
end
