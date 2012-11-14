module PlazrStore
  class Brand < ActiveRecord::Base
    ## Relations ##
    has_many :product

    ## Attributes ##
    attr_accessible :name
  end
end
