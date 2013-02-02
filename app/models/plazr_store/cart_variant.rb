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
    # validate :order_must_be_paid

    ## Callbacks ##
    before_save :order_must_be_paid
    after_save :check_amount
    after_save :update_cart

    ## Delegations ##
    delegate :info, :to => :variant
    delegate :name, :to => :variant
    delegate :product, :to => :variant

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

    def shipped?
      self.state == "shipped"
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
      self.cart.update_amount_and_price unless self.state == "shipped"
    end

    protected
      def order_must_be_paid
        order = Cart.with_deleted.find(self.cart_id).order
        if order && !order.paid? && self.state == "shipped"
          order.errors.add(:base, "The order must be paid first!")
          false
          # redirect_to admin_order_path(order) and return
        end
      end

  end
end 
