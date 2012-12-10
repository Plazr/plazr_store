module PlazrStore
  class Admin::VariantsController < ApplicationController
    before_filter :get_product

    def show
      # @product = Product.find(params[:product_id])
      @variant = Variant.find(params[:id])
    end

    def index
      # @product = Product.find(params[:product_id])
      @variants = @product.variants
    end

    def create
      # @product = Product.find(params[:product_id])
      @variant = @product.variants.build params[:variant]

      if @variant.save
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Variant was successfully created.'
      else
        render :new
      end
    end

    def new
      # @product = Product.find(params[:product_id])
      @variant = Variant.new(available: true)
    end

    def edit
      # @product = Product.find(params[:product_id])
      @variant = Variant.find params[:id]
    end

    def update
      # @product = Product.find(params[:product_id])
      @variant = Variant.find(params[:id])

      if @variant.update_attributes(params[:variant])
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Variant was successfully updated.'
      else
        render :edit 
      end
    end

    def destroy
      # @product = Product.find(params[:product_id])
      @variant = Variant.find(params[:id])
      @variant.destroy
      redirect_to admin_product_variants_path
    end

    protected
      def get_product
        @product = Product.find(params[:product_id])
      end
  end
end
