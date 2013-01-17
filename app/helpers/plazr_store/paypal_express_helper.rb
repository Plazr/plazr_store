module PlazrStore
  module PaypalExpressHelper
    include ActiveMerchant::Billing
    
    def assigns_gateway
      @paypal_account = PlazrAuth::PaypalAccount.find_by_store_id(STORE['store_id'])
              
      unless @paypal_account.nil?
        @gateway ||= PaypalExpressGateway.new(
          :login => @paypal_account.api_username,
          :password => @paypal_account.api_password,
          :signature => @paypal_account.signature
        )
      end
    end
    
    def get_setup_purchase_params(request)
      subtotal, shipping, total = get_totals
      
      return to_cents(total), {
        :ip => request.remote_ip,
        :return_url => review_url,
        :cancel_return_url => cart_url,
        :subtotal => to_cents(subtotal),
        :shipping => to_cents(shipping),
        :handling => 0,
        #:tax =>      0,
        :allow_note =>  true,
        #:items => get_items,
        :currency => 'EUR'
      }
    end
    
    def get_items
      current_user.cart.cart_variants.collect do |line_item|
        {
          :name => line_item.info, 
          :quantity => line_item.amount, 
          :amount => to_cents(line_item.unit_price), 
        }        
      end
    end
    
    def get_order_info(gateway_response) 
      #raise gateway_response.inspect
      {
        address: {
          address1: gateway_response.params['street1'], 
          address2: gateway_response.params['street2'],
          city: gateway_response.params['city_name'],
          first_name: gateway_response.params['first_name'],
          last_name: gateway_response.params['last_name'], 
          phone: gateway_response.params['phone'],
          zipcode: gateway_response.params['postal_code'],
        },
        gateway_details: {
          :token => gateway_response.token,
          :payer_id => gateway_response.payer_id,
        }
      }      
    end
    
    def get_totals
      subtotal = current_user.cart.total_price
      preorder = PreOrder.find_by_cart_id(current_user.cart.id)
      shipping = ShipmentCondition.find(preorder.shipment_condition_id).price
      total = subtotal + shipping
      return subtotal, shipping, total
    end
    
    def to_cents(money)
      (money*100).round
    end
  end
end
