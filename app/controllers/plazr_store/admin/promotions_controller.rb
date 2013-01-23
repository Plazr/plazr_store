module PlazrStore
  class Admin::PromotionsController < Admin::ApplicationController 
    
    def show
      @promotion = Promotion.find(params[:id])
    end

    def index
      @promotions = Promotion.order("starts_at DESC, expires_at ASC")
    end

    def new
      @promotion = Promotion.new
      @prod = params[:product]
      @check_prods = []
      @discount_types = DiscountType.promotion_types
      instance_variable_loading
    end

    def create
      @promotion = Promotion.new params[:promotion]

      if @promotion.save
        redirect_to admin_promotion_path(@promotion), :notice => 'Promotion was successfully created.' 
      else
        instance_variable_loading
        process_product_attrs
        @discount_types = DiscountType.promotion_types
        render :new
      end
    end

    def edit
      @promotion = Promotion.find(params[:id])
      @check_prods = []
      @discount_types = DiscountType.promotion_types
      instance_variable_loading
    end

    def update
      @promotion = Promotion.find(params[:id])

      if @promotion.update_attributes(params[:promotion])
        redirect_to admin_promotion_path(@promotion), :notice => 'Promotion was successfully updated.' 
      else
        instance_variable_loading
        process_product_attrs
        @discount_types = DiscountType.promotion_types
        render :edit
      end
    end

    def destroy
      @promotion = Promotion.find(params[:id])
      @promotion.destroy
      redirect_to admin_promotions_path
    end

    def get_location
      super
      @tab = :promotions
    end

    protected
      def instance_variable_loading
        @promotion.get_unselected_products_and_order_by_name
      end
      
      def process_product_attrs
        @check_prods = []
        params[:promotion][:product_promotions_attributes].values.each do |cat_attr|
          @check_prods << cat_attr[:product_id] if cat_attr[:_destroy] == "0"
        end
      end
  end
end