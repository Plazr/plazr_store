require 'spec_helper.rb'

describe PZS::ProductProductCategory, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:product_product_category).should be_valid
  end

  describe "#Relations" do
    it "belongs to a variant" do 
      FactoryGirl.create(:product_product_category).should belong_to :product
    end
    it "belongs to a variant_category" do 
      FactoryGirl.create(:product_product_category).should belong_to :product_category
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a product" do
      FactoryGirl.create(:product_product_category).should validate_presence_of :product
    end
    it "requires the presence of a product_category" do
      FactoryGirl.create(:product_product_category).should validate_presence_of :product_category
    end
  end
end
