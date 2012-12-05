module PlazrStore
  class Order < ActiveRecord::Base
    # belongs_to :user TODO metodo que chama api
    belongs_to :cart
    belongs_to :promotional_code
    belongs_to :coupon
    belongs_to :payment_data
    belongs_to :bill_address, :class_name => "Address"
    belongs_to :ship_address, :class_name => "Address"

    ## Attributes ##
    attr_accessible :adjustment_total, :bill_address_id, :completed_at, :email, :item_total, :payment_state, :ship_address_id, :shipment_state, :state, :total, :user
  end
end
