module PlazrStore
  class ShipmentCondition < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    #has_many :shipment_condition_variants
    #has_many :variants, :through => :shipment_condition_variants
    has_many :orders

    ## Attributes ##
    #attr_accessible :shipment_method, :value
    attr_accessible :service_name, :price, :discount_aditional_item, :service_details

    ## Validations ##
    #validates :shipment_method, presence: true, uniqueness_without_deleted: true
    #validates :value, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :service_name, presence: true, uniqueness_without_deleted: true
    validates :price, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :service_details, presence: true
  end
end
