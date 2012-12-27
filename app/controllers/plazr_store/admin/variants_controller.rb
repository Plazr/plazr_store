module PlazrStore
  class Admin::VariantsController < AdminController
    before_filter :get_product

    def show
      @variant = Variant.find(params[:id])
    end

    def index
      @variants = @product.variants_without_master
    end

    def create
      @variant = @product.variants.build params[:variant]

      if @variant.save
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Variant was successfully created.'
      else
        @variant.get_unselected_variant_categories_and_order_by_name
        @variant.get_multimedia
        render :new
      end
    end

    def new
      @variant = Variant.new(visible: true, :product_id => @product.id)
      build_relations_for_fields_for
    end

    def edit
      @variant = Variant.find params[:id]
      build_relations_for_fields_for
        # build another empty multimedia model for the variants that have more than one image already associated
      @variant.multimedia.build unless !(@variant.multimedia.count > 0)
    end

    def update
      @variant = Variant.find(params[:id])

      if @variant.update_attributes(params[:variant])
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Variant was successfully updated.'
      else
        @variant.get_unselected_variant_categories_and_order_by_name
        @variant.get_multimedia
        # build another empty multimedia model for the variants that have more than one image already associated
        @variant.multimedia.build unless !(@variant.multimedia.count > 0)
        render :edit 
      end
    end

    def destroy
      @variant = Variant.find(params[:id])
      @variant.destroy
      redirect_to admin_product_variants_path
    end

    protected
      def get_product
        @product = Product.find(params[:product_id])
      end

      # builds certain product relations so that fields_for can render properly
      def build_relations_for_fields_for
        # builds variant_categories that are not persisted so that fields_for can render them
        @variant.get_unselected_variant_categories_and_order_by_name
        # builds variant_property_values regarding the variant_properties of the product
        @variant.get_variant_properties_from_product
        # builds multimedia for an image
        @variant.get_multimedia
      end
  end
end
