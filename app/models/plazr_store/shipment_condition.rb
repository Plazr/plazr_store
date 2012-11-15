module PlazrStore
  class ShipmentCondition < ActiveRecord::Base
    ## Relations ##
    has_and_belongs_to_many :variants

    ## Attributes ##
    attr_accessible :active, :shipment_method, :value
  end
end
