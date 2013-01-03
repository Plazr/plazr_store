module PlazrStore
  class Admin::PropertiesController < Admin::ApplicationController

    def show
      @property = Property.find(params[:id])
    end

    def index
      @properties = Property.all
    end

    def new
      @property = Property.new
    end

    def edit
      @property = Property.find(params[:id])
    end

    def create
      @property = Property.new(params[:property])

      if @property.save
        redirect_to admin_property_path(@property), :notice => 'Property was created successfully'
      else
        render :new
      end
    end

    def update
      @property = Property.find(params[:id])

      if @property.update_attributes(params[:property])
        redirect_to admin_property_path(@property), :notice => 'Property was created sucessfully'
      else
        render :edit
      end
    end

    def destroy
      @property = Property.find(params[:id])
      @property.destroy
      redirect_to admin_properties_path
    end

  end
end
