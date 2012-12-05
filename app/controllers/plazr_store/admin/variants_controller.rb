module PlazrStore
  class Admin::VariantsController < ApplicationController
    # before_filter :instance_variable_loading, :only => [:new, :edit]

    def show
      @variant = Variant.find(params[:id])
    end

    def index
      @variants = Variant.all
    end

    def create
      @variant = Variant.new(params[:variant])

      if @variant.save
        redirect_to admin_variant_path(@variant), :notice => 'Variant was successfully created.'
      else
        render :new
      end
    end

    def new
      @variant = Variant.new
    end

    def edit
      @variant = Variant.find params[:id]
    end

    def update
      @variant = Variant.find(params[:id])

      if @variant.update_attributes(params[:variant])
        redirect_to admin_variant_path(@variant), :notice => 'Variant was successfully updated.'
      else
        render :edit 
      end
    end

    def destroy
      @variant = Variant.find(params[:id])
      @variant.destroy
      redirect_to admin_variants_path
    end

    # protected
    #   def instance_variable_loading
    #     @properties = Property.all
    #     @variant_properties = VariantProperty.all
    #   end
  end
end
