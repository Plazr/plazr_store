module PlazrStore
  class Admin::TemplateCustomizationsController < Admin::ApplicationController

    def show
      @template_customization = TemplateCustomization.find(params[:id])
    end

    def index
      @template_customizations = TemplateCustomization.all
    end

    def new
      @template_customization = TemplateCustomization.new
    end

    def edit
      @template_customization = TemplateCustomization.find(params[:id])
    end

    def create
      @template_customization = TemplateCustomization.new(params[:template_customization])

      if @template_customization.save
        redirect_to admin_template_customization_path(@template_customization), :notice => 'TemplateCustomization was created successfully'
      else
        render :new
      end
    end

    def update
      @template_customization = TemplateCustomization.find(params[:id])

      if @template_customization.update_attributes(params[:template_customization])
        redirect_to admin_template_customization_path(@template_customization), :notice => 'TemplateCustomization was created sucessfully'
      else
        render :edit
      end
    end

    def destroy
      @template_customization = TemplateCustomization.find(params[:id])
      @template_customization.destroy
      redirect_to admin_template_customizations_path
    end
  end
end
