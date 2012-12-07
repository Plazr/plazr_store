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

    it "has many variants" do 
      FactoryGirl.create(:product).should have_many :variants
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      FactoryGirl.create(:product).should validate_presence_of :name
    end
    it "does not allow duplicate name" do
      FactoryGirl.create(:product_v2)
      FactoryGirl.build(:product_v2).should_not be_valid
    end
    it "does not allow duplicate slug" do
      FactoryGirl.create(:product_v2)
      FactoryGirl.build(:product_v2).should_not be_valid
    end
  end

  describe "#Public Methods" do
    describe "#has_master?" do
      context "has variants" do
        it "returns true" do
          p = FactoryGirl.create(:product_with_master_variant)
          p.has_master?.should be_true
        end
        it "returns false" do
          p = FactoryGirl.create(:product)
          p.has_master?.should be_false
        end
      end
    end
    describe "#master_variant" do
      pending "@wip"
    end
  end
end
