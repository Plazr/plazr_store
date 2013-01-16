module PlazrStore
  # Controller for the admin to interact with the promotion class
  class Admin::PromotionsController < Admin::ApplicationController 
    
    # Get a promotion with the given id
    def show
      @promotion = Promotion.find(params[:id])
    end

    # Get all the promotions available 
    def index
      @promotions = Promotion.order("starts_at DESC, expires_at ASC")
    end

    # Create a new empty promotion
    def new
      @promotion = Promotion.new
      @prod = params[:product]
      @check_prods = []
      @discount_types = DiscountType.promotion_types
      instance_variable_loading
    end

    # Create a empty promotion with the given information
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

    # Get a promotion with the given id to display in the edit page
    def edit
      @promotion = Promotion.find(params[:id])
      @check_prods = []
      @discount_types = DiscountType.promotion_types
      instance_variable_loading
    end

    # Update a promotion given its id with the given information
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

    # Delete a promotion with the given id
    def destroy
      @promotion = Promotion.find(params[:id])
      @promotion.destroy
      redirect_to admin_promotions_path
    end

    protected

      # Get the list of products that are not in this promotion scope
      def instance_variable_loading
        @promotion.get_unselected_products_and_order_by_name
      end
      
      # Get the attributes of a given promotion
      def process_product_attrs
        @check_prods = []
        params[:promotion][:product_promotions_attributes].values.each do |cat_attr|
          @check_prods << cat_attr[:product_id] if cat_attr[:_destroy] == "0"
        end
      end
  end
end