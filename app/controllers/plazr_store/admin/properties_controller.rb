module PlazrStore
  # Controller for the admin to interact with the properties model
  class Admin::PropertiesController < Admin::ApplicationController

    # Get a product property with the given id
    def show
      @property = Property.find(params[:id])
    end

    # Get all available product properties
    def index
      @properties = Property.all
    end

    # Create a new empty product property
    def new
      @property = Property.new
    end

    # Get a product property with the given id to display in the edit page
    def edit
      @property = Property.find(params[:id])
    end

    # Create a new product property with the given information
    def create
      @property = Property.new(params[:property])

      if @property.save
        redirect_to admin_property_path(@property), :notice => 'Property was created successfully'
      else
        render :new
      end
    end

    # Update a product property with the given id with the given information
    def update
      @property = Property.find(params[:id])

      if @property.update_attributes(params[:property])
        redirect_to admin_property_path(@property), :notice => 'Property was created sucessfully'
      else
        render :edit
      end
    end

    # Delete a product property with the given id
    def destroy
      @property = Property.find(params[:id])
      @property.destroy
      redirect_to admin_properties_path
    end

  end
end
