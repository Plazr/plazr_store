module PlazrStore
  class ProductsController < ApplicationController

    def index
      @products = Product.paginate(:per_page => 5, :page => params[:page])
    end

    def show
      @product = Product.find(params[:id])
    end

  end
end
