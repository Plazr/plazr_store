module PlazrStore
  class Variant < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    belongs_to :product

    has_many :cart_variants
    has_many :carts, :through => :cart_variants

    has_many :multimedia, :dependent => :destroy

    has_many :promotion_variants, :dependent => :destroy
    has_many :promotions, :through => :promotion_variants

    #has_many :shipment_condition_variants, :dependent => :destroy
    #has_many :shipment_conditions, :through => :shipment_condition_variants

    # Specifying the :inverse_of option on associations lets you tell Active Record about inverse relationships and it will optimise object loading
    # It also allows to create a variant and a variant_category belonging to it at the same time, because of presence of variant_id validation on variant_variant_category
    has_many :variant_variant_categories, :dependent => :destroy, :inverse_of => :variant
    has_many :variant_categories, :through => :variant_variant_categories

    has_many :variant_variant_property_values, :dependent => :destroy
    has_many :variant_property_values, :through => :variant_variant_property_values

    has_many :variant_wishlists
    has_many :wishlists, :through => :variant_wishlists

    ## Nested Attributes ##
    accepts_nested_attributes_for :variant_variant_categories, :allow_destroy => true
    accepts_nested_attributes_for :variant_variant_property_values, :allow_destroy => true, 
          :reject_if => proc {|attributes| attributes.any? {|_,v| v.blank?}}

    ## Attributes ##
    attr_accessible :amount_available, :visible, :cost_price, :description, 
                    :is_master, :price, :restock_date, :sku, :product_id, 
                    :variant_variant_categories_attributes, 
                    :variant_variant_property_values_attributes

    ## Validations ##
    validates_presence_of :sku, :visible, :product
    validates :is_master, :inclusion => {:in => [true, false]}
    validates :sku, :uniqueness_without_deleted => true
    validates :price, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :amount_available, numericality: {:only_integer => true, :greater_than_or_equal_to => 0}
    validates :cost_price, numericality: {:greater_than_or_equal_to => 0}, :allow_nil => true

    ## Scopes ##
    # scope :master_variant, where(:is_master => true)
    scope :without_master, where(:is_master => false)

    ## Callbacks ##
    before_validation :set_is_master, :on => :create

    # Delegations
    delegate :name, :to => :product


    ## Instance Methods ##
    def get_unselected_variant_categories_and_order_by_name
      # creates an array for all variant_categories that the variant does not currently have selected
      # and builds them in the variant
      #(VariantCategory.all - self.variant_categories).each do |vc|
      #  self.variant_variant_categories.build(:variant_category => vc) unless self.variant_variant_categories.map(&:variant_category_id).include?(vc.id)
      #end
      # to ensure that all variant_categories are always shown in a consistent order
      #self.variant_variant_categories.sort_by! {|x| x.variant_category.name}
      VariantCategory.parent_categories.sort_by! { |x| x.name }
      VariantCategory.parent_categories.each do |vc|
        self.variant_variant_categories.build(:variant_category => vc)# unless self.variant_variant_categories.map(&:variant_category_id).include?(vc.id)
        vc.child_variant_categories.sort_by! { |x| x.name }
        vc.child_variant_categories.each do |cvc|
          exist = VariantVariantCategory.find_by_variant_id_and_variant_category_id(self.id, cvc.id)
          if !exist
            self.variant_variant_categories.build(:variant_category => cvc)# unless self.variant_variant_categories.map(&:variant_category_id).include?(cvc.id)
          else
          end
        end
      end
    end

    #creates an array for all the variant_properties that are associated to the product of this variant
    def get_variant_properties_from_product
      self.product.variant_properties.each do |vp|
        self.variant_variant_property_values.build(:variant_property_value => vp.variant_property_values.first) unless self.variant_property_values.map(&:variant_property_id).include?(vp.id)
      end
    end

    #method to display descriptive information about a individual variant
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

    # summarizes a variant's information (name and variant properties)
    def info
      info = self.name
      variant_property_values.each do |vpv|
        info << "; #{vpv.presentation}"
      end
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
  end
end
