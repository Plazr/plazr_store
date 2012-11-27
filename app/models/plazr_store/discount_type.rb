module PlazrStore
  class DiscountType < ActiveRecord::Base
    ## Relations ##
    has_many :promotions
    has_many :coupons

    ## Attributes ##
    attr_accessible :description, :name

    validates :name, :presence => true, :uniqueness => true
  end
end
