require_dependency "plazr_store/application_controller"

module PlazrStore
  class PaypalExpressController < ApplicationController
    before_filter :assigns_gateway

    include PaypalExpressHelper

    def checkout
      
      total = ShipmentCondition.find(session['shipment_condition']).price + current_user.cart.total_price
      
      if @gateway.nil?
         redirect_to cart_url, :notice => 'Woops! No Paypal support for this store!' 
         return
      end
      setup_purchase_params = get_setup_purchase_params request
      setup_response = @gateway.setup_purchase(total.to_d, setup_purchase_params)

      redirect_to @gateway.redirect_url_for(setup_response.token)
    end
  end
end
