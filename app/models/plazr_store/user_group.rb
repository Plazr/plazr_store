# encoding: utf-8
module PlazrStore
  class UserGroup < ActiveRecord::Base
    ## Relations ##
    # has_and_belongs_to_many :users TODO metodo que chama api

    ## Attributes ##
    attr_accessible :description, :name
  end
end
