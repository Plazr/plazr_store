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

    ## Callbacks ##
    after_save { logger.info "cart updated" }

    ## Instance Methods ##
    def add(variant, amount = 1)
      cart_variant = self.cart_variants.find_or_initialize_by_variant_id(variant.id)
      cart_variant.add(amount)

      # self.update_attribute(:item_amount, self.item_amount + amount)
      # self.update_attribute(:total_price, self.total_price + (amount * variant.price))

      #cart_variant ||= self.cart_variants.build(variant_id: )
      #self.cart_variants << CartVariant.create(:variant )
    end

    def remove(variant)
      self.cart_variants.find_by_variant_id(variant.id).remove
    end

    def user
      # Get this cart's owner
      PlazrAuth::User.find(self.user_id)
    end

    # def user=(user)
    #   # Set this cart's owner
    #   self.user_id = PlazrAuth::User.find(user.id)
    # end
  end
end
