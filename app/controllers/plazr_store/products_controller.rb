module PlazrStore
  class ProductsController < ApplicationController

    def index
      @products = Product.paginate(:per_page => 5, :page => params[:page])
    end

    def show
      @product = Product.find(params[:product_id])
      if params[:variant_id].nil?
     	@variant = Product.find(params[:product_id]).master_variant
  	  else
		@variant = Variant.find(params[:variant_id])  	  	
  	  end
    end

  end
end
