module PlazrStore
  class Admin::ProductsController < ApplicationController
    before_filter :instance_variable_loading, :only => [:new, :edit]

    def show
      @product = Product.find(params[:id])
    end

    def index
      @products = Product.all
    end

    def create
      @product = Product.new(params[:product])

      if @product.save
        redirect_to admin_product_path(@product), :notice => 'Product was successfully created.'
      else
        instance_variable_loading
        render :new
      end
    end

    def new
      @product = Product.new
      # @master_variant = Variant.new
    end

    def edit
      @product = Product.find params[:id]
    end

    def update
      @product = Product.find(params[:id])

      if @product.update_attributes(params[:product])
        redirect_to admin_product_path(@product), :notice => 'Product was successfully updated.'
      else
        instance_variable_loading
        render :edit 
      end
    end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path
    end

    protected
      def instance_variable_loading
        @properties = Property.all
        @variant_properties = VariantProperty.all
      end
  end
end
