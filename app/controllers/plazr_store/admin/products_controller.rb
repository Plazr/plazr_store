module PlazrStore
  # Controller for the admin to interact with the product class
  class Admin::ProductsController < Admin::ApplicationController

    # Get the variants without master of a given product (an instance of the product itself)
    def show
      @product = Product.find(params[:id])
      @variants = @product.variants_without_master
    end

    # Get all the products
    def index
      @products = Product.all
    end

    # Create a new product with the given information (and the respective variant, which is the product itself)
    def create
      @product = Product.new(params[:product])

      if @product.save
        if !params[:prototypes].nil?
          #cycle through each prototype selected
          params[:prototypes].each do |p|
            @product.create_all_properties_association(p)
            @product.create_all_variant_properties_association(p)
          end
        end
        redirect_to admin_product_path(@product), :notice => 'Product was successfully created.'
      else
        @product.variants.first.multimedia.build
        entities_collections
        build_relations_for_fields_for
        render :new
      end
    end

    # Create a new empty product (and the respective variant, which is the product itself)
    def new
      @product = Product.new

      # # builds a variant so that fields_for can render it, otherwise the relation :variants would be empty and fields_for wouldn't render anything
      # @product.variants.build(:visible => true, :is_master => true)#.get_unselected_variant_categories_and_order_by_name
      
      @variant = @product.variants.build(:visible => true, :is_master => true)
      @variant.multimedia.build

      entities_collections
      build_relations_for_fields_for
    end

    # Get the product with the given id to display in the edit page
    def edit
      @product = Product.find params[:id]
      entities_collections
      build_relations_for_fields_for
    end

    # Update the product of the given id with the given information (also updates its prototypes properties if necessary)
    def update
      @product = Product.find(params[:id])

      if @product.update_attributes(params[:product])
        if !params[:prototypes].nil?
          #cycle through each prototype selected
          params[:prototypes].each do |p|
            @product.create_all_properties_association(p)
            @product.create_all_variant_properties_association(p)
          end
        end
        redirect_to admin_product_path(@product), :notice => 'Product was successfully updated.'
      else
        entities_collections
        build_relations_for_fields_for
        render :edit
      end
    end

    # Delete a product with the given id
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path
    end

    protected
      # Get the collections used on the views for the brand and prototypes relations
      def entities_collections
        @brands = Brand.all
        @prototypes = Prototype.all
      end

      # Builds a product relations so that the forms can render properly
      def build_relations_for_fields_for
        @product.get_unselected_variant_properties_and_order_by_name
        @product.get_unselected_product_categories_and_order_by_name
      end
  end
end
