require 'spec_helper'

describe PZS::ProductProperty, type: :model do

  describe "#Relations" do
    it "belongs to a product" do 
      FactoryGirl.create(:product_property).should belong_to :product
    end
    it "belongs to a property" do 
      FactoryGirl.create(:product_property).should belong_to :property
    end
  end

  describe "#Validations" do
    it "requires the combination of product_id and property_id to be unique" do
      pp = FactoryGirl.create(:product_property)
      FactoryGirl.build(:product_property, :product_id => pp.product_id, :property_id => pp.property_id).should_not be_valid
    end
  end
end