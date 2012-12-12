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

    #Nested Attributes
    accepts_nested_attributes_for :variant_variant_categories, :allow_destroy => true
    accepts_nested_attributes_for :variant_property_values, :allow_destroy => true

    ## Attributes ##
    attr_accessible :amount_available, :visible, :cost_price, :description, 
                    :is_master, :price, :restock_date, :sku, :product_id, 
                    :variant_variant_categories_attributes, 
                    :variant_property_values_attributes

    ## Validations ##
    validates_presence_of :sku, :visible, :product
    validates :is_master, :inclusion => {:in => [true, false]}
    validates :sku, :uniqueness_without_deleted => true
    validates :price, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :amount_available, numericality: {:only_integer => true, :greater_than_or_equal_to => 0}
    validates :cost_price, numericality: {:greater_than_or_equal_to => 0}, :allow_nil => true

    ## Scopes ##
    scope :master_variant, where(:is_master => true)
    scope :without_master, where(:is_master => false)

    ## Callbacks ##
    #it is only activated if this variant has a product_id
    before_validation :set_is_master, :on => :create#, :if => "!product_id.nil?"
    before_save :mark_variant_properties_for_removal

    def get_unselected_variant_categories_and_order_by_name
      # creates an array for all variant_categories that the variant does not currently have selected
      # and builds them in the variant
      (VariantCategory.all - self.variant_categories).each do |vc|
        self.variant_variant_categories.build(:variant_category => vc) unless self.variant_variant_categories.map(&:variant_category_id).include?(vc.id)
      end
      # to ensure that all variant_categories are always shown in a consistent order
      self.variant_variant_categories.sort_by! {|x| x.variant_category.name}
    end

    def get_unselected_variant_properties_and_order_by_name
      (VariantProperty.all - self.variant_properties).each do |vp|
        self.variant_property_values.build(:variant_property => vp) unless self.variant_property_values.map(&:variant_property_id).include?(vp.id)
      end
      self.variant_property_values.sort_by! {|x| x.variant_property.display_name }
    end

    protected
      # if this variant is being created after the creation of a product then is_master is set to true
      # if not (meaning a master variant already exists), is_master is set to false
      def set_is_master
        if self.product.has_master?
          self.is_master = false
        else
          self.is_master = true
        end
        true
      end

      def mark_variant_properties_for_removal
        self.variant_property_values.each do |vpv|
          vpv.mark_for_destruction if vpv.value.blank?
        end
      end
  end
end
