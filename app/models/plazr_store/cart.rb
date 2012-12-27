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

    ## Callbacks ##
    after_save { logger.info "cart updated" }

    ## Instance Methods ##
    def add(variant, amount = 1)
      cart_variant = self.cart_variants.find_or_initialize_by_variant_id(variant.id)
      cart_variant.add(amount)
      #cart_variant ||= self.cart_variants.build(variant_id: )
      #self.cart_variants << CartVariant.create(:variant )
    end

    def remove(variant)
      self.cart_variants.find_by_variant_id(variant.id).remove
    end

  end
end
