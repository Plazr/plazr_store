module PlazrStore
  class CartVariant < ActiveRecord::Base
    ## Relations ##
    belongs_to :cart
    belongs_to :variant

    ## Attributes ##
    attr_accessible :amount, :cart_id, :variant, :variant_id

    ## Callbacks ##
    before_save :check_amount

    ## Delegations ##
    delegate :price, :to => :variant

    ## Public Methods ##
    def add(amount)
      self.update_attribute(:amount, self.amount + amount)
    end

    def remove(amount)
      self.update_attribute(:amount, self.amount - amount)
    end

    def check_amount
      if amount <= 0
        self.destroy
      end
    end

  end
end 
