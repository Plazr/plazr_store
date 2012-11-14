module PlazrStore
  class CartVariant < ActiveRecord::Base
    ## Relations ##
    belongs_to :cart
    belongs_to :variant

    ## Attributes ##
    attr_accessible :amount, :cart_id, :variant_id
  end
end
