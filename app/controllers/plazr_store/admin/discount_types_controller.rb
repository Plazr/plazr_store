module PlazrStore
  class Admin::DiscountTypesController < Admin::ApplicationController

    def show
      @discount_type = DiscountType.find(params[:id])
    end

    def index
      @discount_types = DiscountType.all
    end

    def new
      @discount_type = DiscountType.new
    end

    def edit
      @discount_type = DiscountType.find(params[:id])
    end

    def create
      @discount_type = DiscountType.new(params[:discount_type])

      if @discount_type.save
        redirect_to admin_discount_type_path(@discount_type), :notice => 'Discount type was created successfully'
      else
        render :new
      end
    end

    def update
      @discount_type = DiscountType.find(params[:id])

      if @discount_type.update_attributes(params[:discount_type])
        redirect_to admin_discount_type_path(@discount_type), :notice => 'Discount type was created sucessfully'
      else
        render :edit
      end
    end

    def destroy
      @discount_type = DiscountType.find(params[:id])
      @discount_type.destroy
      redirect_to admin_discount_types_path
    end

  end
end
