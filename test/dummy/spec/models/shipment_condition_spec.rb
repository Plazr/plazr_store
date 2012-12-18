require 'spec_helper'
require 'spec_support'

describe PZS::ShipmentCondition, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:shipment_condition).should be_valid
  end

  describe "#Relations" do
    it "has many orders" do
      FactoryGirl.create(:shipment_condition).should have_many :orders
    end
  end
  
  describe "#Validations" do
    let(:shipment_condition) {FactoryGirl.create(:shipment_condition)}

    it "requires the presence of the service_name" do
      shipment_condition.should validate_presence_of :service_name
    end

    it "requires the presence of the service_details" do
      shipment_condition.should validate_presence_of :service_details
    end


    it "requires the uniqueness of the service_name" do
      FactoryGirl.create(:shipment_condition_v2)
      FactoryGirl.build(:shipment_condition_v2).should_not be_valid
    end
    
    describe "price field" do
      it "must be present" do
        shipment_condition.should validate_presence_of :price
      end
      it "must be numerical" do
        shipment_condition.should validate_numericality_of :price
      end
      it "and must be equal or greater than 0" do
        shipment_condition.price.should be_greater_than_or_equal_to 0
      end
    end
  end
end