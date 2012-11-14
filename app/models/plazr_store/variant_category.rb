module PlazrStore
  class VariantCategory < ActiveRecord::Base
    ## Relations ##
    has_and_belongs_to_many :variants

    ## Attributes ##
    attr_accessible :description, :name
  end
end
