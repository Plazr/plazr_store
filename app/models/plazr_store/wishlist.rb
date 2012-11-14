module PlazrStore
  class Wishlist < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api

    has_and_belongs_to_many :variants

    ## Attributes ##
    attr_accessible :is_private, :name
  end
end
