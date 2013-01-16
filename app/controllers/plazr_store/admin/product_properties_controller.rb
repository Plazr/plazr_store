module PlazrStore
  # Controller for the admin to manage the relation between the product and property models
  class Admin::ProductPropertiesController < Admin::ApplicationController
    before_filter :get_product

    # Build the relation between a given product and a new property
    def index
      @property = Property.new
      @property.product_properties.build
      @product_properties = @product.product_properties
    end

    # Create a new property with the given information
    def create
      @property = Property.new(params[:property])
      # updates all the product_properties already associated
      update_all_product_properties     

      # Checks if the user didn't want to enter a new ProductProperty and if it is the case
      # just get all the ProductProperties
      if (params[:property][:id_name].blank? && 
          params[:property][:product_properties_attributes]['0'][:value].blank?) 
        @product_properties = @product.product_properties
        redirect_to admin_product_product_properties_path(@product), :notice => 'Everything was updated.' 
      # checks to see if the new ProductProperty uses an existent Property and the user wants to
      # insert this value (by entering a value)
      elsif Property.exists?(:id_name => params[:property][:id_name]) && 
          !params[:property][:product_properties_attributes]['0'][:value].blank?
        # get the existent property and create the new relation
        prop = Property.find_by_id_name(params[:property][:id_name])
        ProductProperty.create(:property => prop, :product => @product,
              :value => params[:property][:product_properties_attributes]['0'][:value])  
        redirect_to admin_product_product_properties_path(@product), :notice => 'ProductProperty was successfully associated and everything was updated.'
      # if the property fills the requirements, it is saved and then the user is redirected back to index
      elsif @property.save
        redirect_to admin_product_product_properties_path(@product), :notice => 'ProductProperty was successfully created and everything was updated.'
      # if everything else fails, get all the product_properties and render index
      else
        @product_properties = @product.product_properties
        render :index
      end
    end

    # Delete the relation between a product and a property, given the relation id
    def destroy
      @product_property = ProductProperty.find(params[:id])
      @product_property.destroy
      redirect_to admin_product_product_properties_path(@product)
    end

    protected

      # Get the product with the given id
      def get_product
        @product = Product.find(params[:product_id])
      end

      # Update all the attributes of a given property and the relation between the product and property
      def update_all_product_properties
        params[:pps].each do |k,v|
          Property.find(v[:property_id]).update_attributes(
            :id_name => v[:id_name], :display_name => v[:display_name])
          ProductProperty.find(k).update_attributes(:value => v[:value])
        end
      end
  end
end
