module PlazrStore
  class Variant < ActiveRecord::Base
    ## Relations ##
    belongs_to :product

    has_many :multimedia

    #has_and_belongs_to_many :promotions
    has_many :promotion_variants
    has_many :promotions, :through => :promotion_variants

    #has_and_belongs_to_many :shipment_conditions
    has_many :shipment_condition_variants
    has_many :shipment_conditions, :through => :shipment_condition_variants

    has_many :variant_property_values
    has_many :variant_properties, :through => :variant_property_values

    #has_and_belongs_to_many :variant_categories
    has_many :variant_variant_categories
    has_many :variant_categories, :through => :variant_variant_categories

    #has_and_belongs_to_many :wishlists
    has_many :variant_wishlists
    has_many :wishlists, :through => :variant_wishlists

    ## Attributes ##
    attr_accessible :amount_available, :available, :cost_price, :description, :is_master, :price, :sku
  end
end
