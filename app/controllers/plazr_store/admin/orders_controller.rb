module PlazrStore
  class Admin::OrdersController < Admin::ApplicationController

    include Admin::OrderHelper

    def index
      @orders = Order.paginate(:per_page => 20, :page => params[:page])
    end

    # PUT    /admin/orders/:id/pay(.:format)
    def pay
      order = Order.find(params[:id])
      if order.update_attributes(:payment_state => "paid")
        redirect_to :back
      end
    end

    # PUT    /admin/orders/:order_id/ship/:cart_variant_id(.:format)
    def ship
      order = Order.find(params[:order_id])
      if order.ship_product(params[:cart_variant_id])
        redirect_to :back
      else
        raise
        redirect_to admin_order_path(order)
      end
    end

    def show
      @order = Order.find(params[:id])
    end
  end
end

