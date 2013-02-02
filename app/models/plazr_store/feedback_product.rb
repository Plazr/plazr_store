module PlazrStore
  class FeedbackProduct < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api
    belongs_to :product
    belongs_to :order

    after_save :update_product_rating

    validates :rating, presence: true
    validates :order_id, uniqueness: { scope: :product_id, message: "You already have reviewed this item in this order" }
    
    ## Attributes ##
    attr_accessible :comment, :rating, :product, :order

    protected

      def update_product_rating
        self.product.update_rating unless self.rating.nil?
      end
  end
end
