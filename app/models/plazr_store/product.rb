module PlazrStore
  class Product < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    belongs_to :brand
    belongs_to :prototype

    has_many :feedback_products

    has_many :product_properties
    has_many :properties, :through => :product_properties
    
    has_many :product_variant_properties
    has_many :variant_properties, :through => :product_variant_properties

    ## Attributes ##
    attr_accessible :available_at, :details, :name, :slug, :price_max, :price_min, :rating

    ## Validations ##
    validates :name, presence: true
    validates :slug, :uniqueness_without_deleted => true
  end
end
