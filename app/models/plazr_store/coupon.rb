module PlazrStore
  class Coupon < ActiveRecord::Base
    ## Relations ##
    belongs_to :discount_type
    # belongs_to :user TODO metodo que chama api
    
    ## Attributes ##
    attr_accessible :code, :description, :expires_at, :minimum_cart, :starts_at, :uses_allowed, :value
  end
end
