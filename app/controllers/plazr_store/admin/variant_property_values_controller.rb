module PlazrStore
  class Admin::VariantPropertyValuesController < Admin::ApplicationController
    before_filter :get_variant_property

    def show
      @variant_property_value = VariantPropertyValue.find(params[:id])
    end

    def index
      @variant_property_values = @variant_property.variant_property_values
    end

    def create
      @variant_property_value = @variant_property.variant_property_values.build params[:variant_property_value]

      if @variant_property_value.save
        redirect_to admin_variant_property_variant_property_value_path(@variant_property, @variant_property_value), :notice => 'VariantPropertyValue was successfully created.'
      else
        render :new
      end
    end

    def new
      @variant_property_value = VariantPropertyValue.new
    end

    def edit
      @variant_property_value = VariantPropertyValue.find params[:id]
    end

    def update
      @variant_property_value = VariantPropertyValue.find params[:id]

      if @variant_property_value.update_attributes(params[:variant_property_value])
        redirect_to admin_variant_property_variant_property_value_path(@variant_property, @variant_property_value), :notice => 'VariantPropertyValue was successfully updated.'
      else
        render :edit 
      end
    end

    def destroy
      @variant_property_value = VariantPropertyValue.find(params[:id])
      @variant_property_value.destroy
      redirect_to admin_variant_property_variant_property_values_path
    end

    protected
      def get_variant_property
        @variant_property = VariantProperty.find(params[:variant_property_id])
      end
  end
end
