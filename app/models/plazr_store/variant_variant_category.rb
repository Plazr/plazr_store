module PlazrStore
  class VariantVariantCategory < ActiveRecord::Base

    ## Relations ##
    belongs_to :variant
    belongs_to :variant_category
    
    ## Attributes ##
    attr_accessible :variant_id, :variant_category_id, :variant_category

    # returns true if the variant_category selected is already associated with the 
    # master variant of the given product
    def category_master_variant?(product)
      Product.find_by_id(product.id).master_variant.first.variant_variant_categories.map(&:variant_category_id).include?(self.variant_category_id)
    end
  end
end