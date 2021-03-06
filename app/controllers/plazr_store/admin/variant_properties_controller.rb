# encoding: utf-8
module PlazrStore
  class Admin::VariantPropertiesController < Admin::ApplicationController

    def show
      @variant_property = VariantProperty.find(params[:id])
    end

    def index
      @variant_properties = VariantProperty.all.paginate( page: params['page'], per_page: 10 )
    end

    def new
      @variant_property = VariantProperty.new
    end

    def edit
      @variant_property = VariantProperty.find(params[:id])
    end

    def create
      @variant_property = VariantProperty.new(params[:variant_property])

      if @variant_property.save
        redirect_to admin_variant_property_path(@variant_property), :notice => 'Propriedade de modelo criada com sucesso.'
      else
        render :new
      end
    end

    def update
      @variant_property = VariantProperty.find(params[:id])

      if @variant_property.update_attributes(params[:variant_property])
        redirect_to admin_variant_property_path(@variant_property), :notice => 'Propriedade de modelo actualizada com sucesso.'
      else
        render :edit
      end
    end

    def destroy
      @variant_property = VariantProperty.find(params[:id])
      @variant_property.destroy
      redirect_to admin_variant_properties_path
    end

    def get_location
      super
      @tab = 'products'
    end
  end
end
