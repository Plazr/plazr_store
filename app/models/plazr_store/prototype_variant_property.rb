module PlazrStore
  class PrototypeVariantProperty < ActiveRecord::Base
    ## Relations ##
    belongs_to :prototype
    belongs_to :variant_property
    
    ## Attributes ##
    attr_accessible :prototype_id, :variant_property_id
  end
end
