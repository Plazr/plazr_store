require 'spec_helper.rb'

describe PZS::DiscountType, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:discount_type).should be_valid
  end

  describe "#Relations" do
    it "has many coupons" do
      FactoryGirl.create(:discount_type).shoud have_many :coupons 
    end

    it "has many promotions" do
      FactoryGirl.create(:discount_type).should have_many :promotions
    end
  end
  
  describe "#Validations" do
    it {should validate_presence_of :name}
  end
end