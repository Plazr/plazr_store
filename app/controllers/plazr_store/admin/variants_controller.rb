module PlazrStore
  # Controller for the admin to interact with the product variant model
  class Admin::VariantsController < Admin::ApplicationController
    before_filter :get_product

    # Get the product variant for the given id to display to the user
    def show
      @variant = Variant.find(params[:id])
    end

    # Get all the variants for a given product, if they exist
    def index
      @variants = @product.variants_without_master
    end

    # Create a new variant of a product with the given parameters
    def create
      @variant = @product.variants.build params[:variant]

      if @variant.save
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Variant was successfully created.'
      else
        @variant.multimedia.build
        render :new
      end
    end

    # Create a new empty variant for a given product
    def new
      @variant = Variant.new(visible: true, :product_id => @product.id)
      build_relations_for_fields_for
      @variant.multimedia.build
    end

    # Get the product variant information to display in the edit page
    def edit
      @variant = Variant.find params[:id]
      build_relations_for_fields_for
    end

    # Update the current variant information with the given information
    def update
      @variant = Variant.find(params[:id])

      if @variant.update_attributes(params[:variant])
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Variant was successfully updated.'
      else
        render :edit 
      end
    end

    # Delete the current product variant
    def destroy
      @variant = Variant.find(params[:id])
      @variant.destroy
      redirect_to admin_product_variants_path
    end

    protected

      # Get the product from a given id
      def get_product
        @product = Product.find(params[:product_id])
      end

      # Builds certain product variant relations so that its information can be properly rendered
      def build_relations_for_fields_for
        # builds variant_property_values regarding the variant_properties of the product
        @variant.get_variant_properties_from_product
      end
  end
end
