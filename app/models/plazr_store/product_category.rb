module PlazrStore
  # Class representing a product category
  class ProductCategory < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    # A relation to itself (categories have two levels)
    has_many :child_product_categories, class_name: "ProductCategory", foreign_key: "parent_product_category_id", :dependent => :destroy
    belongs_to :parent_product_category, class_name: "ProductCategory"

    has_many :product_product_categories, :dependent => :destroy
    has_many :products, :through => :product_product_categories
    
    ## Attributes ##
    attr_accessible :description, :name, :is_leaf, :parent_product_category_id

    ## Validations ##
    validates :name, presence: true
    validates :parent_product_category_id, presence: true, :if => :is_child?

    ## Scopes ##
    scope :parent_categories, where(:is_leaf => false)

    ## Callback ##
    before_validation :set_leaf

    # Set if this category is leaf (subcategory) or not
    def set_leaf
      if self.parent_product_category_id.blank?
        self.is_leaf = false
      else
        self.is_leaf = true
      end
      true
    end
  
    # Check if this category is a subcategory
    def is_child?
      self.is_leaf?
    end

    def self.parent_categories_without(id)
      where("is_leaf = ? AND id != ?", false, id)
    end
  end
end
