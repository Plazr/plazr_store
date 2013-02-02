module PlazrStore
  class CategoryCondition < ActiveRecord::Base
    ## Relations ##
    has_many :condition

    ## Attributes ##
    attr_accessible :description
  end
end
