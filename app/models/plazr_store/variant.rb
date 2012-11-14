module PlazrStore
  class Variant < ActiveRecord::Base
    ## Relations ##
    belongs_to :product

    has_many :multimedia

    has_and_belongs_to_many :variant_categories
    has_and_belongs_to_many :shipment_conditions
    has_and_belongs_to_many :wishlists
    has_and_belongs_to_many :promotions

    has_many :variant_property_values
    has_many :variant_properties, :through => :variant_property_values

    ## Attributes ##
    attr_accessible :amount_available, :available, :cost_price, :deleted_at, :description, :is_master, :price, :sku
  end
end
