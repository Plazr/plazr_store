module PlazrStore
  class Variant < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    belongs_to :product

    has_many :cart_variants
    has_many :carts, :through => :cart_variants

    has_many :multimedia, :class_name => "Multimedia"

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
    validates_presence_of :sku, :available, :product
    validates :is_master, :inclusion => {:in => [true, false]}
    validates :sku, :uniqueness_without_deleted => true
    validates :price, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :amount_available, numericality: {:only_integer => true}
    validates :cost_price, numericality: {:greater_than_or_equal_to => 0}, :allow_nil => true


    ## Callbacks ##
    #it is only activated if this variant has a product_id
    before_validation :set_is_master, :on => :create, :if => "!product_id.nil?"

    protected
      # if this variant is being created after the creation of a product is_master is set to true
      # if not, by default it will be false
      def set_is_master
        if !self.product.has_master?
          self.is_master = true
        end
      end
  end
end
