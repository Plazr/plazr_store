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
    attr_accessible :adjustment_total, :billing_address_id, :completed_at, :email, :item_total, 
                    :payment_state, :shipping_address_id, :shipment_condition_id, :shipment_state,
                    :state, :total

    ## Nested Attributes ##
    accepts_nested_attributes_for :billing_address, :allow_destroy => true
    accepts_nested_attributes_for :shipping_address, :allow_destroy => true

    ## Callbacks ##
    after_initialize :load_defaults

    ## Intance Methods ##
    # Get this order's owner
    def user
      PlayAuth::User.find(self.user_id)
    end

    protected
      def load_defaults
        self.cart = current_user.cart
        self.billing_address ||= Address.new
        self.shipping_address ||= Address.new

      end
  end
end
