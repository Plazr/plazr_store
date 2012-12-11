module PlazrStore
  class Admin::VariantCategoriesController < ApplicationController

    def show
      @variant_category = VariantCategory.find(params[:id])
    end

    def index
      @variant_categories = VariantCategory.all
    end

    def new
      @variant_categories = VariantCategory.parent_categories
      @variant_category = VariantCategory.new
    end

    def edit
      @variant_categories = VariantCategory.parent_categories_without_self(params[:id])
      @variant_category = VariantCategory.find(params[:id])
    end

    def create
      @variant_category = VariantCategory.new(params[:variant_category])
      if(!params[:variant_category][:parent_variant_category_id].empty?)
        @variant_category.is_leaf = true
      end

      if @variant_category.save
        redirect_to admin_variant_category_path(@variant_category), :notice => 'VariantCategory was created successfully'
      else
        @variant_categories = VariantCategory.where(is_leaf: false)
        render :new
      end
    end

    def update
      @variant_category = VariantCategory.find(params[:id])

      if @variant_category.update_attributes(params[:variant_category])
        if(!params[:variant_category][:parent_variant_category_id].empty?)
          @variant_category.is_leaf = true
        end
        redirect_to admin_variant_category_path(@variant_category), :notice => 'VariantCategory was created sucessfully'
      else
        @variant_categories = VariantCategory.parent_categories_without_self(params[:id])
        render :edit
      end
    end

    def destroy
      @variant_category = VariantCategory.find(params[:id])
      @variant_category.destroy
      redirect_to admin_variant_categories_path
    end
  end
end