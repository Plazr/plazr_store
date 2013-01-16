module PlazrStore
  # Class representing a relation between a shopping cart and a variant
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

    ## Instance Methods ##

    # Add the amount of the variant to the shopping cart
    def add(amount)
      self.update_attribute(:amount, self.amount + amount)
      self.save
    end

    # Remove the amount of the variant to the shopping cart
    def remove(amount = nil)
      amount ||= self.amount
      self.update_attribute(:amount, self.amount - amount)
      self.save
    end

    # Get the total price of the product variant
    def price
      variant.price * amount
    end

    # Get the price per unit of the product variant
    def unit_price
      variant.price
    end

    # Delete the product variant from the shopping cart if its quantity is 0
    def check_amount
      if amount <= 0
        self.destroy
      end
    end

    # Update the total price and amount of variants on the shopping cart
    def update_cart
      self.cart.update_amount_and_price
    end

  end
end 
