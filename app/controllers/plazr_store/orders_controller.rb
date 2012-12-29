module PlazrStore
  class OrdersController < ApplicationController

    before_filter :get_cart, only: [:new, :create]
    before_filter :get_auxiliar_data, only: [:new, :create]

    def cancel
      @order = Order.find(params[:id])
      # TODO apenas o admin pode fazer isto (talvez staff)
      @order.to_be_cancelled = true

      # flash[:notice] = "Order #{@order.id} set to be cancelled"
      # redirect_to admin_edit_order_path(@order.id)
    end

    def create
      ActiveRecord::Base.transaction do # so that order's cart changes aren't presisted if an error occurs
        @order = Order.new(params[:order])
        @order.load_user(current_user)
        @order.add_cart_and_update_status(@cart)

        if @order.save
          # indicates which is the last order when the receipt action is called
          session[:last_order] = @order.id
          # redirects to last_order receipt
          redirect_to receipt_url
        else
          render :new
        end
      end
    end

    def history
      redirect_to root_url if current_user.nil?
    end

    def new
      @order = Order.new
      #@order.load_user(current_user)
    end

    def receipt
      # redirects to the last order receipt view
      if session.has_key?(:last_order)
        @order = Order.find(session[:last_order])
      else
        redirect_to root_url 
      end
    end

    protected
      def get_auxiliar_data
        @shipment_conditions = ShipmentCondition.all
      end

      def get_cart
        @cart = current_user.cart
      end
  end
end
