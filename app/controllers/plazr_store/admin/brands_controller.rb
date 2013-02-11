# encoding: utf-8
module PlazrStore
  class Admin::BrandsController < Admin::ApplicationController
    def show
      @brand = Brand.find(params[:id])
    end

    def index
      @brands = Brand.all.paginate( page: params['page'], per_page: 10 )
    end

    def create
      @brand = Brand.new(params[:brand])

      if @brand.save
        redirect_to admin_brand_path(@brand), :notice => 'Marca criada com sucesso.'
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
        redirect_to admin_brand_path(@brand), :notice => 'Marca atualizada com sucesso.'
      else
        render :edit 
      end
    end

    def destroy
      @brand = Brand.find(params[:id])
      @brand.destroy
      redirect_to admin_brands_path
    end

    def get_location
      super
      @tab = 'products'
    end
  end
end
