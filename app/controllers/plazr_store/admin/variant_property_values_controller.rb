module PlazrStore
  # Controller for the admin to interact with the property values of a product variant
  class Admin::VariantPropertyValuesController < Admin::ApplicationController
    before_filter :get_variant_property

    # Get a property value of a product variant given its id
    def show
      @variant_property_value = VariantPropertyValue.find(params[:id])
    end

    # Get the property values of a given product variant property
    def index
      @variant_property_values = @variant_property.variant_property_values
    end

    # Create a new property value for a product variant with the given information
    def create
      @variant_property_value = @variant_property.variant_property_values.build params[:variant_property_value]

      if @variant_property_value.save
        redirect_to admin_variant_property_variant_property_value_path(@variant_property, @variant_property_value), :notice => 'VariantPropertyValue was successfully created.'
      else
        render :new
      end
    end

    # Create a new empty property value not yet associated with a product variant
    def new
      @variant_property_value = VariantPropertyValue.new
    end

    # Get the property value of a product variant for the given id to display in the edit page
    def edit
      @variant_property_value = VariantPropertyValue.find params[:id]
    end

    # Update the property value of a product variant for a given id
    def update
      @variant_property_value = VariantPropertyValue.find params[:id]

      if @variant_property_value.update_attributes(params[:variant_property_value])
        redirect_to admin_variant_property_variant_property_value_path(@variant_property, @variant_property_value), :notice => 'VariantPropertyValue was successfully updated.'
      else
        render :edit 
      end
    end

    # Delete the property value of a product variant for a given id
    def destroy
      @variant_property_value = VariantPropertyValue.find(params[:id])
      @variant_property_value.destroy
      redirect_to admin_variant_property_variant_property_values_path
    end

    protected

      # Get the product varuant property for a given id
      def get_variant_property
        @variant_property = VariantProperty.find(params[:variant_property_id])
      end
  end
end
