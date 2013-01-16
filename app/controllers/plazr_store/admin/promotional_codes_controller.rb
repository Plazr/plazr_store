module PlazrStore
  class Admin::PromotionalCodesController < Admin::ApplicationController 

    def show
      @promotional_code = PromotionalCode.find(params[:id]) 
    end

    def index
      @promotional_codes = PromotionalCode.order("starts_at DESC, expires_at ASC")
    end

    def new
      @promotional_code = PromotionalCode.new
      @discount_types = DiscountType.promotional_code_types
    end

    def create
      @promotional_code = PromotionalCode.new params[:promotional_code]

      if @promotional_code.save
        redirect_to admin_promotional_code_path(@promotional_code), :notice => 'PromotionalCode was successfully created.' 
      else
        @discount_types = DiscountType.promotional_code_types
        render :new
      end
    end

    def edit
      @promotional_code = PromotionalCode.find(params[:id])
      @discount_types = DiscountType.promotional_code_types
    end

    def update
      @promotional_code = PromotionalCode.find(params[:id])

      if @promotional_code.update_attributes(params[:promotional_code])
        redirect_to admin_promotional_code_path(@promotional_code), :notice => 'PromotionalCode was successfully updated.' 
      else
        @discount_types = DiscountType.promotional_code_types
        render :edit
      end
    end

    def destroy
      @promotional_code = PromotionalCode.find(params[:id])
      @promotional_code.destroy
      redirect_to admin_promotional_codes_path
    end
  end
end