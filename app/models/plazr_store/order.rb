module PlazrStore
  class Order < ActiveRecord::Base
    belongs_to :cart
    belongs_to :promotional_code
    belongs_to :coupon
    belongs_to :billing_address, :class_name => "Address"
    belongs_to :shipping_address, :class_name => "Address"
    belongs_to :shipment_condition

    has_one :payment


    ## Attributes ##
    attr_accessible :adjustment_total, :billing_address_id, :cart_id, :completed_at, :email, :item_total, 
      :payment_state, :shipping_address_id, :shipment_condition_id, :shipment_state,
      :state, :total, :user_id


    ## Validations ##
    validates :email,:item_total, :adjustment_total, :total, :payment_state, :shipment_state, :state, :shipment_condition_id, :cart_id, presence: true
    validate :completed_at_and_state_matches, :on => :update


    ## Nested Attributes ##
    accepts_nested_attributes_for :cart
    accepts_nested_attributes_for :billing_address, :allow_destroy => true
    accepts_nested_attributes_for :shipping_address, :allow_destroy => true


    ## Callbacks ##
    after_initialize :load_defaults
    # TODO feature postponed to another release
    # before_save :update_status
    after_save :deliver_order_confirmation#, :if => Proc.new { |order| alguma_coisa_aqui != "admin" }


    ## Intance Methods ##
    def add_cart_and_update_status(cart)
      cart.each do |c|
        c.status = "processing"
      end
      self.cart = cart
    end

    def load_user(user)
      if user
        self.user = user
        self.email = user.email 
      end
    end

    def user
      # Get this order's owner
      PlazrAuth::User.find(self.user_id)
    end

    # def user=(user)
    #   # Set this cart's owner
    #   self.user_id = PlazrAuth::User.find(user.id)
    # end

    protected
      def completed_at_and_state_matches
        # TODO
        # errors.add(:base, "finished state matches completed_at") unless completed_at && state == "finished"
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

      def update_status
        # Updates the order status depending on cart's variants statuses
        #TODO precisa de guardar info do status ao nivel do variant
      end
  end
end
