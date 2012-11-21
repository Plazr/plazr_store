module PlazrStore
  class PromotionalCode < ActiveRecord::Base
    ## Relations ##
    has_many :orders

    ## Attributes ##
    attr_accessible :code, :description, :expires_at, :minimum_cart, :starts_at, :uses_allowed, :value
  end
end