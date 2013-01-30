module PlazrStore
  class ProductsController < ApplicationController

    def index
      @products = Product.paginate(:per_page => 5, :page => params[:page])
    end

    def show
      @product = Product.find(params[:product_id])
      if @product.variants_without_master.empty?
     	  @variant = @product.master_variant
  	  else
		    @variant = @product.variants_without_master.first
  	  end
    end

  end
end
