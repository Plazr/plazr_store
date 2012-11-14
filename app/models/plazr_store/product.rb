module PlazrStore
  class Product < ActiveRecord::Base
    ## Relations ##
    belongs_to :brand
    belongs_to :prototype

    ## Attributes ##
    attr_accessible :active, :available_at, :deleted_at, :details, :name, :permalink, :price_max, :price_min, :rating
  end
end
