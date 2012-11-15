module PlazrStore
  class ProductProperty < ActiveRecord::Base
    ## Relations ##
    belongs_to :product
    belongs_to :property

    ## Attributes ##
    attr_accessible :value
  end
end
