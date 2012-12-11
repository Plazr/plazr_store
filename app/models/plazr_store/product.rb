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
    attr_accessible :available_at, :details, :name, :slug, :rating, :brand_id, :prototype_id, :property_ids, :variant_property_ids
    accepts_nested_attributes_for :variants, :allow_destroy => true

    ## Validations ##
    validates :name, presence: true, uniqueness_without_deleted: true
    validates :slug, :uniqueness_without_deleted => true

    ## Methods ##
    def has_master?
      self.variants.count >= 1
    end

    def master_variant
      self.variants.master_variant
    end

    def variants_without_master
      self.variants.without_master
    end

    def has_variants?
      self.variants_without_master.count >= 1
    end
  end
end
