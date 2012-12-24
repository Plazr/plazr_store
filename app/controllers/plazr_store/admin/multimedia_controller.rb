module PlazrStore
  class Admin::MultimediaController < ApplicationController
    before_filter :get_product

    def show
      @multimedium = Multimedium.find params[:id]
    end

    def index
      @multimedia = Multimedium.where(:variant_id => Variant.where(:product_id => @product).map(&:id))
    end

    def create
      @multimedium = Multimedium.new params[:multimedium]

      if @multimedium.save
        redirect_to admin_product_multimedium_path(@product, @multimedium), :notice => 'Multimedium was successfully created.'
      else
        entity_collection
        render :new
      end
    end

    def new
      @multimedium = Multimedium.new
      entity_collection
    end

    def edit
      @multimedium = Multimedium.find params[:id]
      entity_collection
    end

    def update
      @multimedium = Multimedium.find params[:id]

      if @multimedium.update_attributes(params[:multimedium])
        redirect_to admin_product_multimedium_path(@product, @multimedium), :notice => 'Multimedium was successfully updated.'
      else
        entity_collection
        render :edit 
      end
    end

    def destroy
      @multimedium = Multimedium.find(params[:id])
      @multimedium.destroy
      redirect_to admin_product_multimedia_path(@product)
    end

    protected
      def get_product
        @product = Product.find(params[:product_id])
      end

      # collections used on the views for the belongs_to relations
      def entity_collection
        @variants = @product.variants
      end
  end
end
