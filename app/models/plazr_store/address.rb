module PlazrStore
  class Address < ActiveRecord::Base
    ## Relations ##
    has_one :payment_data_as_bill, :foreign_key=>:bill_address_id, :class_name=>"PaymentData"
    has_one :payment_data_as_ship, :foreign_key=>:ship_address_id, :class_name=>"PaymentData"

    has_one :order_as_bill, :foreign_key=>:bill_address_id, :class_name=>"Order"
    has_one :order_as_ship, :foreign_key=>:ship_address_id, :class_name=>"Order"

    ## Attributes ##
    attr_accessible :active, :address1, :address2, :alternative_phone, :city, :company, :first_name, :last_name, :phone, :zipcode
  end
end
