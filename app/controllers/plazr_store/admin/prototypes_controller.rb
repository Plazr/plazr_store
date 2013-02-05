# encoding: utf-8
module PlazrStore
  class Admin::PrototypesController < Admin::ApplicationController

    def show
      @prototype = Prototype.find(params[:id])
    end

    def index
      @prototypes = Prototype.all.paginate( page: params['page'], per_page: 10 )
    end

    def create
      @prototype = Prototype.new(params[:prototype])

      if @prototype.save
        redirect_to admin_prototype_path(@prototype), :notice => 'Protótipo criado com sucesso.'
      else
        instance_variable_loading
        render :new
      end
    end

    def new
      @prototype = Prototype.new
      instance_variable_loading
    end

    def edit
      @prototype = Prototype.find params[:id]
      instance_variable_loading
    end

    def update
      @prototype = Prototype.find(params[:id])

      if @prototype.update_attributes(params[:prototype])
        redirect_to admin_prototype_path(@prototype), :notice => 'Protótipo atualizado com sucesso.'
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

    def get_location
      super
      @tab = 'products'
    end

    protected
      def instance_variable_loading
        @prototype.get_unselected_properties_and_order_by_name
        @prototype.get_unselected_variant_properties_and_order_by_name
      end
  end
end
