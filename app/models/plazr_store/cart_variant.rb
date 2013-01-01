module PlazrStore
  class CartVariant < ActiveRecord::Base
    ## Relations ##
    belongs_to :cart
    belongs_to :variant

    ## Attributes ##
    attr_accessible :amount, :cart_id, :variant, :variant_id, :state

    ## Validations ##
    validates_numericality_of :amount
    validates_inclusion_of :state, :in => %w( pending processing shipped )

    ## Callbacks ##
    after_save :check_amount
    after_save :update_cart

    ## Delegations ##
    delegate :info, :to => :variant
    delegate :name, :to => :variant
    delegate :product, :to => :variant
    delegate :price, :to => :variant

    ## Instance Methods ##
    def add(amount)
      self.update_attribute(:amount, self.amount + amount)
      self.save
    end

    def remove(amount = nil)
      amount ||= self.amount
      self.update_attribute(:amount, self.amount - amount)
      self.save
    end

    def price
      variant.price * amount
    end

    def unit_price
      variant.price
    end

    def check_amount
      if amount <= 0
        self.destroy
      end
    end

    def update_cart
      self.cart.update_amount_and_price
    end

  end
end 
