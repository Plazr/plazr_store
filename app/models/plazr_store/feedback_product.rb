module PlazrStore
  class FeedbackProduct < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api
    belongs_to :product
    belongs_to :order

    validates :rating, presence: true
    validates :order_id, uniqueness: { scope: :product_id, message: "You already have reviewed this item in this order" }
    
    ## Attributes ##
    attr_accessible :comment, :rating, :product, :order
  end
end
