# encoding: utf-8
module PlazrStore
  class Cart < ActiveRecord::Base
    include PZS::ParanoiaInterface

    ## Relations ##

    has_one :order

    has_many :cart_variants
    has_many :variants, :through => :cart_variants

    ## Attributes ##
    attr_accessible :item_amount, :total_price, :user_id

    ## Validations ##
    validates :user_id, presence: true


    ## Instance Methods ##
    def add(variant, amount = 1)
      cart_variant = self.cart_variants.find_or_initialize_by_variant_id(variant.id)
      cart_variant.add(amount)
    end

    def remove(variant)
      self.cart_variants.find_by_variant_id(variant.id).remove
    end

    def user
      # Get this cart's owner
      PlazrAuth::User.find(self.user_id)
    end
    
    def update_total_price
      total = 0 
      self.cart_variants.each do |cv|
        total += cv.price
      end
      self.update_attribute(:total_price, total)
    end

    # def user=(user)
    #   # Set this cart's owner
    #   self.user_id = PlazrAuth::User.find(user.id)
    # end

    def update_amount_and_price
      self.update_attributes(
        item_amount: self.cart_variants.map(&:amount).sum,
        total_price: self.cart_variants.map(&:price).sum
      )
    end

  end
end
