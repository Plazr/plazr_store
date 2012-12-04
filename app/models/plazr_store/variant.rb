module PlazrStore
  class Variant < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    belongs_to :product

    has_many :multimedia

    has_many :promotion_variants
    has_many :promotions, :through => :promotion_variants

    has_many :shipment_condition_variants
    has_many :shipment_conditions, :through => :shipment_condition_variants

    has_many :variant_property_values
    has_many :variant_properties, :through => :variant_property_values

    has_many :variant_variant_categories
    has_many :variant_categories, :through => :variant_variant_categories

    has_many :variant_wishlists
    has_many :wishlists, :through => :variant_wishlists

    ## Attributes ##
    attr_accessible :amount_available, :available, :cost_price, :description, :is_master, :price, :sku, :product_id

    ## Validations ##
    validates_presence_of :name, :sku, :price, :available, :amount_available, :is_master, :product_id 
    validates :sku, :uniqueness_without_deleted => true
  end
end
