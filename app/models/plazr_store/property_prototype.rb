module PlazrStore
  # Class representing a property associated to a prototype
  class PropertyPrototype < ActiveRecord::Base
    ## Relations ##
    belongs_to :property
    belongs_to :prototype
    
    ## Attributes ##
    attr_accessible :property_id, :prototype_id, :property
  end
end
