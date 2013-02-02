module PlazrStore
  class Admin::ShipmentConditionsController < Admin::ApplicationController

    def show
      @shipment_condition = ShipmentCondition.find(params[:id])
    end

    def index
      @shipment_conditions = ShipmentCondition.all
    end

    def new
      @shipment_condition = ShipmentCondition.new
    end

    def edit
      @shipment_condition = ShipmentCondition.find(params[:id])
    end

    def create
      @shipment_condition = ShipmentCondition.new(params[:shipment_condition])

      if @shipment_condition.save
        redirect_to admin_shipment_condition_path(@shipment_condition), :notice => 'ShipmentCondition was created successfully'
      else
        render :new
      end
    end

    def update
      @shipment_condition = ShipmentCondition.find(params[:id])

      if @shipment_condition.update_attributes(params[:shipment_condition])
        redirect_to admin_shipment_condition_path(@shipment_condition), :notice => 'ShipmentCondition was created sucessfully'
      else
        render :edit
      end
    end

    def destroy
      @shipment_condition = ShipmentCondition.find(params[:id])
      @shipment_condition.destroy
      redirect_to admin_shipment_conditions_path
    end

    def get_location
      super
      @tab = 'pages'
    end
  end
end
