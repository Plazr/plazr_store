module PlazrStore
  # Class defining a category for stores
  class StoreCategory < ActiveRecord::Base

    # TODO herdar do Plazr e retirar migracao
    ## Attributes ##
    attr_accessible :description, :name

    ## Relations ##
  end
end
