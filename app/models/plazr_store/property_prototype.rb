module PlazrStore
  class PropertyPrototype < ActiveRecord::Base
    ## Relations ##
    belongs_to :property
    belongs_to :prototype
    
    ## Attributes ##
    attr_accessible :property_id, :prototype_id
  end
end
