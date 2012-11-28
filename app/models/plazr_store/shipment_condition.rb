module PlazrStore
  class ShipmentCondition < ActiveRecord::Base
    ## Relations ##
    #has_and_belongs_to_many :variants
    has_many :shipment_condition_variants
    has_many :variants, :through => :shipment_condition_variants

    ## Attributes ##
    attr_accessible :shipment_method, :value
  end
end
