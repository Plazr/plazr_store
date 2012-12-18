module PlazrStore
  class ProductsController < ApplicationController
    def show
      @product = Product.find(params[:id])
    end

    def index
      @products = Product.all
      # @product_pages, @products = paginate :products
    end
  end
end
