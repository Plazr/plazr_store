module PlazrStore
  class ShipmentConditionVariant < ActiveRecord::Base
    ## Relations ##
    belongs_to :shipment_condition
    belongs_to :variant
    
    ## Attributes ##
    attr_accessible :shipment_condition_id, :variant_id
  end
end