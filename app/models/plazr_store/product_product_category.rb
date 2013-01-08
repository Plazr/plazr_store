module PlazrStore
  class ProductProductCategory < ActiveRecord::Base

    ## Relations ##
    belongs_to :product
    belongs_to :product_category
    
    ## Attributes ##
    attr_accessible :product_id, :product_category_id, :product_category

    ## Validations ##
    validates :product, presence: true
    validates :product_category, presence: true
  end
end