module PlazrStore
  class VariantVariantCategory < ActiveRecord::Base

    ## Relations ##
    belongs_to :variant
    belongs_to :variant_category
    
    ## Attributes ##
    attr_accessible :variant_id, :variant_category_id, :variant_category
  end
end