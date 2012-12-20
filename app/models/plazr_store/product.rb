module PlazrStore
  class Product < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    belongs_to :brand
    belongs_to :prototype

    has_many :feedback_products
    # Specifying the :inverse_of option on associations lets you tell Active Record about inverse relationships and it will optimise object loading
    has_many :variants, :dependent => :destroy, :inverse_of => :product

    has_many :product_properties
    has_many :properties, :through => :product_properties

    has_many :product_variant_properties
    has_many :variant_properties, :through => :product_variant_properties

    ## Attributes ##
    attr_accessible :available_at, :details, :name, :slug, :rating, :brand_id, :prototype_id, :property_ids, :variant_property_ids, :variants_attributes, :product_variant_properties_attributes, :product_properties_attributes
    accepts_nested_attributes_for :variants, :allow_destroy => true
    accepts_nested_attributes_for :product_variant_properties, :allow_destroy => true
    # rejects any product_property that is selected but value is blank
    accepts_nested_attributes_for :product_properties, :allow_destroy => true#, 
    # :reject_if => proc {|attributes| attributes.any? {|k,v| k == 'value' && v.blank?}}


    ## Validations ##
    validates :name, presence: true, uniqueness_without_deleted: true
    validates :slug, :uniqueness_without_deleted => true


    ## Callbacks ##
    before_save :mark_properties_for_removal


    ## Instance Methods ##
    def has_master?
      self.variants.count >= 1
    end

    def master_variant
      self.variants.master_variant
    end

    def master_price
      self.variants.master_variant.first.price
    end

    def variants_without_master
      self.variants.without_master
    end

    def has_variants?
      self.variants_without_master.count >= 1
    end

    def get_unselected_variant_properties_and_order_by_name
      # creates an array for all variant_properties that the product does not currently have selected
      # and builds them in the product
      (VariantProperty.all - self.variant_properties).each do |var_prop|
        self.product_variant_properties.build(:variant_property => var_prop) unless self.product_variant_properties.map(&:variant_property_id).include?(var_prop.id)
      end
      # to ensure that all variant_properties are always shown in a consistent order
      self.product_variant_properties.sort_by! {|x| x.variant_property.display_name }
    end

    def get_unselected_properties_and_order_by_name
      # creates an array for all properties that the product does not currently have selected
      # and builds them in the product
      (Property.all - self.properties).each do |prop|
        self.product_properties.build(:property => prop) unless self.product_properties.map(&:property_id).include?(prop.id)
      end
      # to ensure that all properties are always shown in a consistent order
      self.product_properties.sort_by! {|x| x.property.display_name }
    end


    ## Class Methods ##
    def self.search(search)
      if search
        where('name LIKE ?', "%#{search}%")
      else
        # returns Model.all in a scope so it can be queriable
        scoped
      end
    end


    protected
    def mark_properties_for_removal
      self.product_properties.each do |pv|
        pv.mark_for_destruction if pv.value.blank?
      end
    end
  end
end
