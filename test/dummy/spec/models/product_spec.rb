require 'spec_helper'

describe PZS::Product, type: :model do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:product).should be_valid
  end

  describe "#Relations" do
    it "belongs to brand" do 
      FactoryGirl.create(:product).should belong_to :brand
    end

    it "belongs to prototype" do 
      FactoryGirl.create(:product).should belong_to :prototype
    end

    it "has many feedback_products" do 
      FactoryGirl.create(:product).should have_many :feedback_products
    end

    it "has many product_properties" do
      FactoryGirl.create(:product).should have_many :product_properties
    end
    it "has many properties through product_properties" do
      FactoryGirl.create(:product).should have_many(:properties).through(:product_properties)
    end

    it "has many product_variant_properties" do
      FactoryGirl.create(:product).should have_many :product_variant_properties
    end
    it "has many variant_properties through product_variant_properties" do
      FactoryGirl.create(:product).should have_many(:variant_properties).through(:product_variant_properties)
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      FactoryGirl.create(:product).should validate_presence_of :name
    end
    it "does not allow duplicate slug " do
      FactoryGirl.create(:product, slug: "prodcut-x")
      FactoryGirl.build(:product, slug: "prodcut-x").should_not be_valid
    end
  end
end
