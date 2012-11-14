module PlazrStore
  class StoreCategory < ActiveRecord::Base
    ## Attributes ##
    attr_accessible :description, :name

    ## Relations ##
  end
end
