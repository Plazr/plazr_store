module PlazrStore
  class PromotionVariant < ActiveRecord::Base
    ## Relations ##
    belongs_to :promotion
    belongs_to :variant
    
    ## Attributes ##
    attr_accessible :promotion_id, :variant_id
  end
end