module PlazrStore
  # Controller for the admin to interact with the multimedia model
  class Admin::MultimediaController < Admin::ApplicationController
    before_filter :get_product

    # Get a multimedia with the given id
    def show
      @multimedium = Multimedium.find params[:id]
    end

    # Get all the multimedia of all variants of a given product
    def index
      @multimedia = Multimedium.multimedia_from_all_variants_of_a_product(@product)
    end

    # Create a multimedia with the given information and file
    def create
      @multimedium = Multimedium.new params[:multimedium]

      if @multimedium.save
        redirect_to admin_product_multimedium_path(@product, @multimedium), :notice => 'Multimedium was successfully created.'
      else
        entity_collection
        render :new
      end
    end

    # Create a new empty multimedia object
    def new
      @multimedium = Multimedium.new
      entity_collection
    end

    # Get a multimedia with the given id to display on the edit page
    def edit
      @multimedium = Multimedium.find params[:id]
      entity_collection
    end

    # Update the multimedia of a given id with the given information
    def update
      @multimedium = Multimedium.find params[:id]

      if @multimedium.update_attributes(params[:multimedium])
        redirect_to admin_product_multimedium_path(@product, @multimedium), :notice => 'Multimedium was successfully updated.'
      else
        entity_collection
        render :edit 
      end
    end

    # Delete a multimedia object with the given id
    def destroy
      @multimedium = Multimedium.find(params[:id])
      if @multimedium.destroy
        FileUtils.rm_rf(":rails_root/public/assets/upload/variants/" << params[:id])  
      end
      redirect_to admin_product_multimedia_path(@product)
    end

    protected

      # Get a product with the given id
      def get_product
        @product = Product.find(params[:product_id])
      end

      # Get a collection used on the views for the relation between a variant and products
      def entity_collection
        @variants = @product.variants
      end
  end
end
