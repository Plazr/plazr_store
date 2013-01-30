module PlazrStore
  class PreOrder #< ActiveRecord::Base
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
        
		attr_accessor :shipment_condition_id#, :cart_id
		
		validates_presence_of :shipment_condition_id#, :cart_id
		
		def initialize(attributes = {})
		  attributes.each do |name, value|
		    send("#{name}=", value)
		  end
		end
		
		def persisted?
		  false
		end
  end
end
