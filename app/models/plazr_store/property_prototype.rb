# encoding: utf-8
module PlazrStore
  class PropertyPrototype < ActiveRecord::Base
    ## Relations ##
    belongs_to :property
    belongs_to :prototype
    
    ## Attributes ##
    attr_accessible :property_id, :prototype_id, :property
  end
end
