# encoding: utf-8
module PlazrStore
  class StoreCategory < ActiveRecord::Base

    # TODO herdar do Plazr e retirar migracao
    ## Attributes ##
    attr_accessible :description, :name

    ## Relations ##
  end
end
