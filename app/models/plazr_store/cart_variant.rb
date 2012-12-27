module PlazrStore
  class CartVariant < ActiveRecord::Base
    ## Relations ##
    belongs_to :cart
    belongs_to :variant

    ## Attributes ##
    attr_accessible :amount, :cart_id, :variant, :variant_id

    ## Validations ##
    validates_numericality_of :amount

    ## Callbacks ##
    after_save :check_amount

    ## Delegations ##
    delegate :info, :to => :variant
    delegate :name, :to => :variant
    delegate :product, :to => :variant

    ## Public Methods ##
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

  end
end 
