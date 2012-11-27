module PlazrStore
  class Admin::BrandsController < ApplicationController
    def show
      @brand = Brand.find(params[:id])
    end

    def index
      @brands = Brand.all
    end

    def create
      @brand = Brand.new(params[:brand])

      if @brand.save
        redirect_to admin_brand_path(@brand), :notice => 'Brand was successfully created.'
      else
        render :new
      end
    end

    def new
      @brand = Brand.new
    end

    def edit
      @brand = Brand.find params[:id]
    end

    def update
      @brand = Brand.find(params[:id])

      if @brand.update_attributes(params[:brand])
        redirect_to admin_brand_path(@brand), :notice => 'Brand was successfully updated.'
      else
        render :edit 
      end
    end

    def destroy
      @brand = Brand.find(params[:id])
      @brand.destroy
      redirect_to admin_brands_path
    end
  end
end
