module PlazrStore
  class Variant < ActiveRecord::Base
    ## Relations ##

    ## Attributes ##
    attr_accessible :amount_available, :available, :cost_price, :deleted_at, :description, :is_master, :price, :sku
  end
end
