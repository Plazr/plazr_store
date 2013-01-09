module PlazrStore
  class FeedbackProductsController < ApplicationController

    before_filter :load_params, only: [:new, :create]

    def new
      @feedback_product = FeedbackProduct.new(order: @order, product: @product)
    end

    def create
      @feedback_product = FeedbackProduct.new(params[:feedback_product])
      @feedback_product.user_id = current_user.id
      @feedback_product.order   = @order
      @feedback_product.product = @product
      if @feedback_product.save
        flash[:success] = "Review saved! Thank you"
        redirect_to order_path(@order)
      else
        render :new
      end
    end


    protected

      def load_params
        @order   = Order.find(params[:id])
        @product = Product.find(params[:product_id])
      end

  end
end
