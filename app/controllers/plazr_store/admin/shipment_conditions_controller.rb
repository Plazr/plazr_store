module PlazrStore
  # Controller for the admin to interact with the shipment condition model
  class Admin::ShipmentConditionsController < Admin::ApplicationController

    # Get a shipment condition from a given id
    def show
      @shipment_condition = ShipmentCondition.find(params[:id])
    end

    # Get all shipment conditions
    def index
      @shipment_conditions = ShipmentCondition.all
    end

    # Create a new empty shipment condition
    def new
      @shipment_condition = ShipmentCondition.new
    end

    # Get a shipment condition with the given id to display in the edit page
    def edit
      @shipment_condition = ShipmentCondition.find(params[:id])
    end

    # Create a new shipment condition with the given information
    def create
      @shipment_condition = ShipmentCondition.new(params[:shipment_condition])

      if @shipment_condition.save
        redirect_to admin_shipment_condition_path(@shipment_condition), :notice => 'ShipmentCondition was created successfully'
      else
        render :new
      end
    end

    # Update a shipment condition for a given id with the given information
    def update
      @shipment_condition = ShipmentCondition.find(params[:id])

      if @shipment_condition.update_attributes(params[:shipment_condition])
        redirect_to admin_shipment_condition_path(@shipment_condition), :notice => 'ShipmentCondition was created sucessfully'
      else
        render :edit
      end
    end

    # Delete a shipment condition for a given id
    def destroy
      @shipment_condition = ShipmentCondition.find(params[:id])
      @shipment_condition.destroy
      redirect_to admin_shipment_conditions_path
    end
  end
end
