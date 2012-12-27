module PlazrStore
  class VariantCategory < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    # A relation to itself (categories have two levels)
    has_many :child_variant_categories, class_name: "VariantCategory", foreign_key: "parent_variant_category_id", :dependent => :destroy
    belongs_to :parent_variant_category, class_name: "VariantCategory"

    has_many :variant_variant_categories, :dependent => :destroy
    has_many :variants, :through => :variant_variant_categories
    
    ## Attributes ##
    attr_accessible :description, :name, :is_leaf, :parent_variant_category_id

    ## Validations ##
    validates :name, presence: true
    validates :parent_variant_category_id, presence: true, :if => :is_child?

    ## Scopes ##
    scope :parent_categories, where(:is_leaf => false)

    ## Callback ##
    before_validation :set_leaf

    def set_leaf
      if self.parent_variant_category_id.blank?
        self.is_leaf = false
      else
        self.is_leaf = true
      end
      true
    end
  
    def is_child?
      self.is_leaf?
    end

    def self.parent_categories_without(id)
      where("is_leaf = ? AND id != ?", false, id)
    end
  end
end
