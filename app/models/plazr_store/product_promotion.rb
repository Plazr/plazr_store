# encoding: utf-8
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
        promotion.errors.add(:base, "#{self.product.name} já tem uma promoção ativa neste período. Promoção cancelada")
        false
      end
    end

    ## Validations ##
    validates :product, :presence => true
    validates :promotion, :presence => true
  end
end