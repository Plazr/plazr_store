module PlazrStore
  class Admin::MultimediaController < Admin::ApplicationController
    before_filter :get_product

    def show
      @multimedium = Multimedium.find params[:id]
    end

    def index
      @multimedia = Multimedium.multimedia_from_all_variants_of_a_product(@product)
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
      if @multimedium.destroy
        FileUtils.rm_rf(":rails_root/public/assets/upload/variants/" << params[:id])  
      end
      redirect_to admin_product_multimedia_path(@product)
    end

    protected
      def get_product
        @product = Product.find(params[:product_id])
      end

      # collection used on the views for the belongs_to relation with a variant
      def entity_collection
        @variants = @product.variants
      end
  end
end
