module PlazrStore
  class PrototypeVariantCategory < ActiveRecord::Base
    ## Relations ##
    belongs_to :prototype
    belongs_to :variant_category
    
    ## Attributes ##
    attr_accessible :prototype_id, :variant_category_id
  end
end