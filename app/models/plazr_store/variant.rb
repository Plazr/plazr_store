module PlazrStore
  # Class representing a variant, which is an instance of a product
  class Variant < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    belongs_to :product

    has_many :cart_variants
    has_many :carts, :through => :cart_variants

    has_many :multimedia, :dependent => :destroy, :inverse_of => :variant

    #has_many :shipment_condition_variants, :dependent => :destroy
    #has_many :shipment_conditions, :through => :shipment_condition_variants

    has_many :variant_variant_property_values, :dependent => :destroy
    has_many :variant_property_values, :through => :variant_variant_property_values

    has_many :variant_wishlists
    has_many :wishlists, :through => :variant_wishlists

    ## Nested Attributes ##
    accepts_nested_attributes_for :variant_variant_property_values, :allow_destroy => true, 
          :reject_if => proc {|attributes| attributes.any? {|_,v| v.blank?}}
    accepts_nested_attributes_for :multimedia, :allow_destroy => true,
          :reject_if => proc { |t| t['file'].nil? }

    ## Attributes ##
    attr_accessible :amount_available, :visible, :cost_price, :description, 
                    :is_master, :price, :restock_date, :sku, :product_id, 
                    :variant_variant_property_values_attributes,
                    :multimedia_attributes

    ## Validations ##
    validates_presence_of :sku, :visible, :product
    validates :is_master, :inclusion => {:in => [true, false]}
    validates :sku, :uniqueness_without_deleted => true
    validates :price, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :amount_available, numericality: {:only_integer => true, :greater_than_or_equal_to => 0}
    validates :cost_price, numericality: {:greater_than_or_equal_to => 0}, :allow_nil => true

    ## Scopes ##
    scope :without_master, where(:is_master => false)

    ## Callbacks ##
    before_validation :set_is_master, :on => :create

    # Delegations
    delegate :name, :to => :product


    ## Instance Methods ##

    # Override method price to return the price of a variant with the active promotion applied
    def price
      promotion = self.product.promotions.active_promotions.first
      if promotion.nil?
        read_attribute(:price)
      elsif promotion.discount_type.type_id == 1
        read_attribute(:price) - (read_attribute(:price) * (promotion.value/100))
      elsif promotion.discount_type.type_id == 3
        promotion.value
      else
        read_attribute(:price)
      end
    end

    # Get an array for all the variant properties that are associated to the product of this variant
    def get_variant_properties_from_product
      self.product.variant_properties.each do |vp|
        self.variant_variant_property_values.build(:variant_property_value => vp.variant_property_values.first) unless self.variant_property_values.map(&:variant_property_id).include?(vp.id)
      end
    end

    # Display descriptive information about an individual variant
    def variant_description
      #if it is the master_variant, then the image is aplicable to all variants
      if self.is_master?
        "All"
      else
        res = ""
        self.variant_variant_property_values.each do |vvpv|
          res << "#{vvpv.variant_property_value.variant_property.id_name}: #{vvpv.variant_property_value.name}, "
        end
        res.chop.chop
      end
    end

    # Get an image associated with this variant
    # If it does not exists it creates a new default image
    def image
      images = self.multimedia
      if images.size > 0
        images.first
      else
        Multimedium::new(type: 'variant')
      end
    end

    # Summarizes a variant's information (name and variant properties)
    def info
      info = self.name
      variant_property_values.each do |vpv|
        info << "; #{vpv.presentation}"
      end
      info
    end

    protected
      # If this variant is being created after the creation of a product then is_master is set to true
      # If not (meaning a master variant already exists), is_master is set to false
      def set_is_master
        if self.product.has_master?
          self.is_master = false
        else
          self.is_master = true
        end
        true
      end
  end
end
