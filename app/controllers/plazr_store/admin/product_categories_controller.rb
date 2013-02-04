# encoding: utf-8
module PlazrStore
  class Admin::ProductCategoriesController < Admin::ApplicationController

    def show
      @product_category = ProductCategory.find(params[:id])
    end

    def index
      @product_categories = ProductCategory.all.paginate( page: params['page'], per_page: 10 )
    end

    def new
      @product_categories = ProductCategory.parent_categories
      @product_category = ProductCategory.new
    end

    def edit
      @product_category = ProductCategory.find(params[:id])
      @product_categories = []
      if @product_category.child_product_categories.empty?
        @product_categories = ProductCategory.parent_categories_without(params[:id])
      end 
    end

    def create
      @product_category = ProductCategory.new(params[:product_category])
      if(!params[:product_category][:parent_product_category_id].empty?)
        @product_category.is_leaf = true
      end

      if @product_category.save
        redirect_to admin_product_category_path(@product_category), :notice => 'Categoria de produtos criada com sucesso.'
      else
        @product_categories = ProductCategory.where(is_leaf: false)
        render :new
      end
    end

    def update
      @product_category = ProductCategory.find(params[:id])

      if @product_category.update_attributes(params[:product_category])
        if(!params[:product_category][:parent_product_category_id].empty?)
          @product_category.is_leaf = true
        end
        redirect_to admin_product_category_path(@product_category), :notice => 'Categoria de produtos atualizada com sucesso.'
      else
        @product_categories = []
        if @product_category.child_product_categories.empty?
          @product_categories = ProductCategory.parent_categories_without(params[:id])
        end 
        render :edit
      end
    end

    def destroy
      @product_category = ProductCategory.find(params[:id])
      @product_category.destroy
      redirect_to admin_product_categories_path
    end

    def get_location
      super
      @tab = :products
    end
  end
end