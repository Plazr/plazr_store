module PlazrStore
  class VariantCategory < ActiveRecord::Base
    ## Relations ##
    #has_and_belongs_to_many :variants
    has_many :variant_variant_categories
    has_many :variants, :through => :variant_variant_categories

    ## Attributes ##
    attr_accessible :description, :name
  end
end
