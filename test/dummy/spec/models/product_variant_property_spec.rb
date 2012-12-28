require 'spec_helper'

describe PZS::ProductVariantProperty, type: :model do
  describe "#Relations" do
    it "belongs to a product" do 
      FactoryGirl.create(:product_variant_property).should belong_to :product
    end
    it "belongs to a property" do 
      FactoryGirl.create(:product_variant_property).should belong_to :variant_property
    end
  end

  describe "#Validations" do
    it "requires the combination of product_id and variant_property_id to be unique" do
      pvp = FactoryGirl.create(:product_variant_property)
      FactoryGirl.build(:product_variant_property, :product_id => pvp.product_id, :variant_property_id => pvp.variant_property_id).should_not be_valid
    end
  end
end