module PlazrStore
  class ProductsController < ApplicationController
    def show
      @product = Product.find(params[:id])
    end

    def index
      @products = Product.paginate(:per_page => 5, :page => params[:page])
    end
  end
end
