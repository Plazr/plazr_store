require 'spec_helper.rb'

describe PZS::DiscountType, :type => :model, :skip => true do

  it "should create a new valid instance" do
    FactoryGirl.create(:discount_type).should be_valid
  end

  describe "#Relations" do
    it "has many promotional_codes" do
      FactoryGirl.create(:discount_type).should have_many :promotional_codes 
    end

    it "has many promotions" do
      FactoryGirl.create(:discount_type).should have_many :promotions
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a name" do
      FactoryGirl.create(:discount_type).should validate_presence_of :name
    end
  end
end
