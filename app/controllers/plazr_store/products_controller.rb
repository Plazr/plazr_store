module PlazrStore
  # Controller for interacting with the product model
  class ProductsController < ApplicationController

  	# Get products to present on the product's index page of the store
    def index
      @products = Product.paginate(:per_page => 5, :page => params[:page])
    end

    # Get a specific product with a given id
    def show
      @product = Product.find(params[:id])
    end

  end
end
