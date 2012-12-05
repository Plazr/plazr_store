module PlazrStore
  class Promotion < ActiveRecord::Base
    ## Relations ##
    belongs_to :discount_type

    #has_and_belongs_to_many :variants
    has_many :promotion_variants
    has_many :variants, :through => :promotion_variants

    ## Attributes ##
    attr_accessible :description, :expires_at, :name, :starts_at, :value
  end
end
