# encoding: utf-8
module PlazrStore
  class Admin::ShipmentConditionsController < Admin::ApplicationController

    def show
      @shipment_condition = ShipmentCondition.find(params[:id])
    end

    def index
      # @shipment_conditions = ShipmentCondition.all
      @shipment_conditions = ShipmentCondition.all.paginate(:page => params[:page], :per_page => 10)
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
        redirect_to admin_shipment_condition_path(@shipment_condition), :notice => 'Meio de entrega criado com sucesso'
      else
        render :new
      end
    end

    def update
      @shipment_condition = ShipmentCondition.find(params[:id])

      if @shipment_condition.update_attributes(params[:shipment_condition])
        redirect_to admin_shipment_condition_path(@shipment_condition), :notice => 'Meio de entrega actualizado com sucesso'
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
      @tab = 'orders'
    end
  end
end
