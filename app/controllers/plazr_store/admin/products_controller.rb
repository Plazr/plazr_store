module PlazrStore
  class Admin::ProductsController < Admin::ApplicationController
    def show
      @product = Product.find(params[:id])
      @variants = @product.variants_without_master
    end

    def index
      @products = Product.all
    end

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
        entities_collections
        build_relations_for_fields_for
        render :new
      end
    end

    def new
      @product = Product.new
      
      # builds a variant so that fields_for can render it, otherwise the relation :variants would be empty and fields_for wouldn't render anything
      @product.variants.build(:visible => true, :is_master => true)#.get_unselected_variant_categories_and_order_by_name
      entities_collections
      build_relations_for_fields_for
    end

    def edit
      @product = Product.find params[:id]
      #@product.master_variant.first.get_unselected_variant_categories_and_order_by_name
      entities_collections
      build_relations_for_fields_for
    end

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

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path
    end

    protected
      # collections used on the views for the belongs_to relations
      def entities_collections
        @brands = Brand.all
        @prototypes = Prototype.all
      end
    
      # builds certain product relations so that fields_for can render properly
      def build_relations_for_fields_for
        # builds variant_properties that are not persisted so that fields_for can render them
        @product.get_unselected_variant_properties_and_order_by_name
        @product.get_unselected_product_categories_and_order_by_name
      end
  end
end
