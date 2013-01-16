module PlazrStore
  # Controller for the admin to interact with the product variant properties
  class Admin::VariantPropertiesController < Admin::ApplicationController

    # Get a product variant property for a given id
    def show
      @variant_property = VariantProperty.find(params[:id])
    end

    # Get all the variant properties
    def index
      @variant_properties = VariantProperty.all
    end

    # Create a new empty product variant property
    def new
      @variant_property = VariantProperty.new
    end

    # Get a product variant property for a given id
    def edit
      @variant_property = VariantProperty.find(params[:id])
    end

    # Create a new product variant property with the given information
    def create
      @variant_property = VariantProperty.new(params[:variant_property])

      if @variant_property.save
        redirect_to admin_variant_property_path(@variant_property), :notice => 'VariantProperty was created successfully'
      else
        render :new
      end
    end

    # Update a prodcut variant property with the given information
    def update
      @variant_property = VariantProperty.find(params[:id])

      if @variant_property.update_attributes(params[:variant_property])
        redirect_to admin_variant_property_path(@variant_property), :notice => 'VariantProperty was created sucessfully'
      else
        render :edit
      end
    end

    # Delete a product variant property with the given id
    def destroy
      @variant_property = VariantProperty.find(params[:id])
      @variant_property.destroy
      redirect_to admin_variant_properties_path
    end

  end
end
