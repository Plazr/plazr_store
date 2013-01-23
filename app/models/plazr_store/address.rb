module PlazrStore
  class Address < ActiveRecord::Base
    ## Relations ##
    has_one :order_billing, :foreign_key=>:billing_address_id, :class_name=>"Order"
    has_one :order_shipping, :foreign_key=>:shipping_address_id, :class_name=>"Order"

    ## Attributes ##
    attr_accessible :address1, :address2, :alternative_phone, :city, :company, :first_name, :last_name, :phone, :zipcode

    ## Validators ##
    validates :address1, :city, :first_name, :last_name, :phone, :zipcode, presence: true
    validates_format_of :phone, :with => /((\+351|00351|351)?)(2\d{1}|(9(3|6|2|1)))\d{7}/, :on => :create    
    validates_format_of :alternative_phone, :with => /((\+351|00351|351)?)(2\d{1}|(9(3|6|2|1)))\d{7}/, :on => :create, :allow_blank => true    
    validates_format_of :zipcode, :with => /[0-9]{4,4}(-[0-9]{3,3})?/, :on => :create 

    ## Instance Methods ##
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
