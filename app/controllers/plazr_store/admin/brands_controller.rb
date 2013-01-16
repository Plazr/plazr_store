module PlazrStore
  # Controller for the admin to interact with the brand model
  class Admin::BrandsController < Admin::ApplicationController

    # Get a brand with the given id
    def show
      @brand = Brand.find(params[:id])
    end

    # Get all brands available
    def index
      @brands = Brand.all
    end

    # Create a new brand with the given information
    def create
      @brand = Brand.new(params[:brand])

      if @brand.save
        redirect_to admin_brand_path(@brand), :notice => 'Brand was successfully created.'
      else
        render :new
      end
    end

    # Create a new empty brand object
    def new
      @brand = Brand.new
    end

    # Get a brand with the given id to display in the edit page
    def edit
      @brand = Brand.find params[:id]
    end

    # Update a brand of a given id with the given information
    def update
      @brand = Brand.find(params[:id])

      if @brand.update_attributes(params[:brand])
        redirect_to admin_brand_path(@brand), :notice => 'Brand was successfully updated.'
      else
        render :edit 
      end
    end

    # Delete a brand with the given id
    def destroy
      @brand = Brand.find(params[:id])
      @brand.destroy
      redirect_to admin_brands_path
    end
  end
end
