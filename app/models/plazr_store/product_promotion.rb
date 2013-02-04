module PlazrStore
  class ProductPromotion < ActiveRecord::Base
    ## Relations ##
    belongs_to :product
    belongs_to :promotion
    
    ## Attributes ##
    attr_accessible :product_id, :promotion_id, :product, :promotion
    
    ## Callbacks ##
    before_save :one_active_promotion

    def one_active_promotion
      if self.product.promotions.where("(? BETWEEN starts_at AND expires_at) OR (? BETWEEN starts_at AND expires_at) OR (? >= starts_at AND expires_at IS NULL)", self.promotion.starts_at, self.promotion.expires_at, self.promotion.starts_at).count > 0
        self.promotion.errors.add(:base, "#{self.product.name} already has a promotion in this period of time. Promotion not created")
        #puts self.promotion.errors.inspect
        puts self.promotion
        false
      end
    end

    ## Validations ##
    validates :product, :presence => true
    validates :promotion, :presence => true
  end
end