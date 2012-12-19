module PlazrStore
  class Cart < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api
    include PZS::ParanoiaInterface

    has_one :order

    has_many :cart_variants
    has_many :variants, :through => :cart_variants

    ## Attributes ##
    attr_accessible :item_amount, :total_price, :user_id
  end
end
