module PlazrStore
  class Admin::OrdersController < Admin::ApplicationController

    def index
      @orders = Order.paginate(:per_page => 5, :page => params[:page])
    end

    # PUT    /admin/orders/:id/pay(.:format)
    def pay
      order = Order.find(params[:id])
      order.update_attributes(:state => 'paid')
      redirect_to :back
    end

    # PUT    /admin/orders/:order_id/ship/:cart_variant_id(.:format)
    def ship
      order = Order.find(params[:id])
      # order.save
      redirect_to :back
    end

    def show
      @order = Order.find(params[:id])
    end
  end
end

