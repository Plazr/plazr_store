module PlazrStore
  # Class representing an order made by a costumer on a store associated to a shopping cart
  # Can have promotions associated and must a have billing and shipping address
  class Order < ActiveRecord::Base
    belongs_to :cart
    belongs_to :promotional_code
    belongs_to :billing_address, :class_name => "Address"
    belongs_to :shipping_address, :class_name => "Address"
    belongs_to :shipment_condition

    has_one :payment


    ## Attributes ##
    attr_accessible :adjustment_total, :billing_address_id, :cart_id, :completed_at, :email, :item_total, 
      :payment_state, :shipping_address_id, :shipment_condition_id, :shipment_state, :promotional_code_id,
      :state, :total, :user_id, :billing_address_attributes, :shipping_address_attributes
    attr_accessor :to_be_cancelled, :promotional_code


    ## Validations ##
    validates :email, :item_total, :adjustment_total, :total, :payment_state, :shipment_state, :state,
              :shipment_condition_id, :cart_id, :user_id, presence: true
    validate :completed_at_and_state_match, :on => :update
    validates_inclusion_of :state, :in => %w( processing shipped cancelled paid )


    ## Nested Attributes ##
    accepts_nested_attributes_for :billing_address, :allow_destroy => true
    accepts_nested_attributes_for :shipping_address, :allow_destroy => true


    ## Delegations ##
    delegate :variants, :cart_variants, :to => :cart


    ## Callbacks ##
    after_initialize :load_defaults
    before_validation :set_promotional_code_and_validate_code
    before_save :update_state
    after_save :deliver_order_confirmation#, :if => Proc.new { |order| alguma_coisa_aqui != "admin" }
    # after_commit :mark_cart_as_deleted


    ## Intance Methods ##
    
    # Associates the shopping cart of the current user to the order and updates cart's products state to 'processing'
    def add_cart_and_update_status(cart)
      cart.cart_variants.each do |c|
        c.state = "processing"
      end
      if cart.save
        self.cart = cart
      end
    end

    # Gets the shopping cart of the user even if it is marked as deleted
    def cart
      PZS::Cart.with_deleted.find(self.cart_id)
    end

    # Summarize an order's information
    def info
      info = "Order ##{self.id}"
      info << "; State: #{self.state}"
      info << "; Creation Date: #{self.created_at.strftime("%m-%d-%Y")}"
      info
    end

    # Associates the current user information to the order
    def load_user(user)
      if user
        self.user_id = user.id
        self.email = user.email 
      end
    end

    # Get the current order owner
    def user
      PlazrAuth::User.find(self.user_id)
    end

    protected
    # Check if the state of the order is 'shipped' and it is defined the date completed
    def completed_at_and_state_match
      errors.add(:base, "'shipped' state doesn't match completed_at") if completed_at && state != "shipped"
    end

    # Send a confirmation to the order's owner 
    def deliver_order_confirmation
      Notifier.order_notification(self).deliver
    end

    # Load the default information to this order
    def load_defaults
      self.billing_address ||= Address.new
      self.shipping_address ||= Address.new

      self.payment_state = "processing"
      self.shipment_state = "processing"
      self.state = "processing"
    end

    # def mark_cart_as_deleted
    #   # marks this order's cart as deleted 
    #   PZS::Cart.find(this.cart.id).delete
    # end

    # Validates and associates a given promotional code to the order
    def set_promotional_code_and_validate_code
      # 
    end

    # Updates the order state depending on the shopping cart's variants status
    def update_state
      return if self.state == "cancelled"
      
      if self.to_be_cancelled
        self.state = "cancelled"
      elsif cart_variants.all? { |cv| cv.state == "shipped" }
        self.state = "shipped"
      elsif cart_variants.all? { |cv| cv.state == "processing" }
        self.state = "processing"
      end
    end
  end
end
