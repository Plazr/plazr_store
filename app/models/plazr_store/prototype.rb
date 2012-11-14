module PlazrStore
  class Prototype < ActiveRecord::Base
    ## Relations ##
    has_many :product
    has_and_belongs_to_many :property

    ## Attributes ##
    attr_accessible :active, :name
  end
end
