module PlazrStore
  # Controller for the admin to interact with the product prototype model
  class Admin::PrototypesController < Admin::ApplicationController

    # Get a product prototype for the given id 
    def show
      @prototype = Prototype.find(params[:id])
    end

    # Get all the product prototypes
    def index
      @prototypes = Prototype.all
    end

    # Create a new product prototype with the given information
    def create
      @prototype = Prototype.new(params[:prototype])

      if @prototype.save
        redirect_to admin_prototype_path(@prototype), :notice => 'Prototype was successfully created.'
      else
        instance_variable_loading
        render :new
      end
    end

    # Create a new empty product prototype
    def new
      @prototype = Prototype.new
      instance_variable_loading
    end

    # Get a product prototype with the given id to display in the edit page
    def edit
      @prototype = Prototype.find params[:id]
      instance_variable_loading
    end

    # Update a product prototype of a given id with the given information
    def update
      @prototype = Prototype.find(params[:id])

      if @prototype.update_attributes(params[:prototype])
        redirect_to admin_prototype_path(@prototype), :notice => 'Prototype was successfully updated.'
      else
        instance_variable_loading
        render :edit 
      end
    end

    # Delete a product prototype with the given id
    def destroy
      @prototype = Prototype.find(params[:id])
      @prototype.destroy
      redirect_to admin_prototypes_path
    end

    protected

      # Get all the properties that can be associated to the prototype
      def instance_variable_loading
        @prototype.get_unselected_properties_and_order_by_name
        @prototype.get_unselected_variant_properties_and_order_by_name
      end
  end
end
