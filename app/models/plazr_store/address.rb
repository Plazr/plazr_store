module PlazrStore
  # Class for representing an address
  # Can be used for billing and shipping
  class Address < ActiveRecord::Base
    ## Relations ##
    has_one :order_billing, :foreign_key=>:billing_address_id, :class_name=>"Order"
    has_one :order_shipping, :foreign_key=>:shipping_address_id, :class_name=>"Order"

    ## Attributes ##
    attr_accessible :address1, :address2, :alternative_phone, :city, :company, :first_name, :last_name, :phone, :zipcode

    ## Validators ##
    validates :address1, :city, :first_name, :last_name, :phone, :zipcode, presence: true

    ## Instance Methods ##
    
    # Displays the address with html tags
    def display
      address = "#{self.first_name} #{self.last_name}<br />"
      address += "#{self.address1}<br />"
      if self.address2 && !self.address2.blank?
        address += "#{self.address2}<br />"
      end
      address += "#{self.city}, #{self.zipcode}<br />"
      address
    end
  end
end
