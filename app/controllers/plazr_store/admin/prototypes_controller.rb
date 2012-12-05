module PlazrStore
  class Admin::PrototypesController < ApplicationController
    before_filter :instance_variable_loading, :only => [:new, :edit]

    def show
      @prototype = Prototype.find(params[:id])
    end

    def index
      @prototypes = Prototype.all
    end

    def create
      @prototype = Prototype.new(params[:prototype])

      if @prototype.save
        redirect_to admin_prototype_path(@prototype), :notice => 'Prototype was successfully created.'
      else
        instance_variable_loading 
        render :new
      end
    end

    def new
      @prototype = Prototype.new
    end

    def edit
      @prototype = Prototype.find params[:id]
    end

    def update
      @prototype = Prototype.find(params[:id])

      if @prototype.update_attributes(params[:prototype])
        redirect_to admin_prototype_path(@prototype), :notice => 'Prototype was successfully updated.'
      else
        instance_variable_loading
        render :edit 
      end
    end

    def destroy
      @prototype = Prototype.find(params[:id])
      @prototype.destroy
      redirect_to admin_prototypes_path
    end

    protected
      def instance_variable_loading
        @properties = Property.all
        @variant_properties = VariantProperty.all
      end
  end
end
