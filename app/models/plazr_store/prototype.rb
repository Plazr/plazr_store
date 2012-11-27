module PlazrStore
  class Prototype < ActiveRecord::Base
    ## Relations ##
    has_many :product
    has_and_belongs_to_many :properties
    has_and_belongs_to_many :variant_properties

    ## Attributes ##
    attr_accessible :name
  end
end
