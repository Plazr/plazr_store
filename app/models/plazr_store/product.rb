module PlazrStore
  class Product < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    belongs_to :brand

    has_many :feedback_products
    # Specifying the :inverse_of option on associations lets you tell Active Record about inverse relationships and it will optimise object loading
    # It also allows to create a product and a variant belonging to it at the same time, because of presence of product_id validation on variation
    has_many :variants, :dependent => :destroy, :inverse_of => :product

    has_many :product_properties
    has_many :properties, :through => :product_properties

    has_many :product_variant_properties
    has_many :variant_properties, :through => :product_variant_properties

    ## Attributes ##
    attr_accessible :available_at, :details, :name, :slug, :rating, :brand_id,
                    :property_ids, :variant_property_ids, 
                    :variants_attributes, :product_variant_properties_attributes, 
                    :product_properties_attributes, :brand_attributes

    # Nested Attributes
    accepts_nested_attributes_for :variants, :allow_destroy => true
    accepts_nested_attributes_for :product_variant_properties, :allow_destroy => true
    accepts_nested_attributes_for :product_properties, :allow_destroy => true
    accepts_nested_attributes_for :brand

    ## Validations ##
    validates :name, presence: true, uniqueness_without_deleted: true
    validates :slug, presence: true, uniqueness_without_deleted: true

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

    def create_all_properties_association(prototype_id)
      # replicate each property related to the prototype to the product
      Prototype.find(prototype_id).properties.each do |prop|
        self.product_properties.create :property => prop, :value => 0
      end
    end

    def create_all_variant_properties_association(prototype_id)
      # replicate each variant_property related to the prototype to the product
      Prototype.find(prototype_id).variant_properties.each do |vp|
        self.product_variant_properties.create :variant_property => vp
      end
    end
  end
end
