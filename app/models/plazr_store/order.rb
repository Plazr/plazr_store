module PlazrStore
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
      :state, :total, :user_id, :billing_address_attributes, :shipping_address_attributes,
      :express_token, :gateway
      
    attr_accessor :to_be_cancelled, :promotional_code, :gateway


    ## Validations ##
    validates :email,:item_total, :adjustment_total, :total, :payment_state, :shipment_state, :state,
              :shipment_condition_id, :cart_id, presence: true
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


    ## Intance Methods ##
    def add_cart_and_update_status(cart)
      cart.cart_variants.each do |c|
        c.state = "processing"
      end
      cart.save
      self.cart = cart
    end

    def load_user(user)
      if user
        self.user_id = user.id
        self.email = user.email 
      end
    end

    def user
      # Get this order's owner
      PlazrAuth::User.find(self.user_id)
    end

    protected
    def completed_at_and_state_match
      errors.add(:base, "'shipped' state doesn't match completed_at") unless completed_at && state == "shipped"
    end

    def deliver_order_confirmation
      Notifier.order_notification(self).deliver
    end

    def load_defaults
      self.billing_address ||= Address.new
      self.shipping_address ||= Address.new

      self.payment_state = "processing"
      self.shipment_state = "processing"
      self.state = "processing"
    end

    def set_promotional_code_and_validate_code
    end

    def update_state
      # Updates the order status depending on cart's variants status
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
