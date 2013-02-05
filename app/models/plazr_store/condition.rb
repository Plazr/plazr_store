# encoding: utf-8
module PlazrStore
  class Condition < ActiveRecord::Base
    ## Relations ##
    belongs_to :category_condition

    ## Attributes ##
    attr_accessible :condition
  end
end
