module PlazrStore
  class ProductsController < ApplicationController
    def show
      @product = Product.find(params[:id])
      puts "HERE "+@product.inspect
      puts "HERE "+@product.master_variant.inspect
    end

    def index
      @products = Product.paginate(:per_page => 5, :page => params[:page])
    end
  end
end
