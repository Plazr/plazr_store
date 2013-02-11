# encoding: utf-8
module PlazrStore
  class Admin::VariantsController < Admin::ApplicationController
    before_filter :get_product

    def show
      @variant = Variant.find(params[:id])
    end

    def index
      @variants = @product.variants_without_master.paginate( page: params['page'], per_page: 19 )
    end

    def create
      @variant = @product.variants.build params[:variant]

      if @variant.save
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Modelo criado com sucesso.'
      else
        @variant.multimedia.build
        build_relations_for_fields_for

        @variant.variant_variant_property_values.each do |vvpv|
          puts vvpv.variant_property_value.inspect
        end
        render :new
      end
    end

    def new
      @variant = Variant.new(visible: true, :product_id => @product.id)
      build_relations_for_fields_for
      @variant.multimedia.build
    end

    def edit
      @variant = Variant.find params[:id]
      build_relations_for_fields_for
    end

    def update
      @variant = Variant.find(params[:id])

      if @variant.update_attributes(params[:variant])
        redirect_to admin_product_variant_path(@product, @variant), :notice => 'Modelo atualizado com sucesso.'
      else
        build_relations_for_fields_for        
        render :edit 
      end
    end

    def destroy
      @variant = Variant.find(params[:id])
      @variant.destroy
      redirect_to admin_product_variants_path
    end

    def get_location
      super
      @tab = :products
    end

    protected
      def get_product
        @product = Product.find(params[:product_id])
      end

      # builds certain variant relations so that fields_for can render properly
      def build_relations_for_fields_for
        # builds variant_property_values regarding the variant_properties of the product
        @variant.get_variant_properties_from_product
      end
  end
end
