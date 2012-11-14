module PlazrStore
  class DiscountType < ActiveRecord::Base
    ## Relations ##
    has_many :promotions

    ## Attributes ##
    attr_accessible :description, :name
  end
end
