require 'spec_helper'
require 'spec_support'

describe PZS::ShipmentCondition, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:shipment_condition).should be_valid
  end

  describe "#Relations" do
    it "has many shipment_condition_variants" do
      FactoryGirl.create(:shipment_condition).should have_many :shipment_condition_variants
    end

    it "has many variants through shipment_condition_variants" do
      FactoryGirl.create(:shipment_condition).should have_many(:variants).through(:shipment_condition_variants)
    end
  end
  
  describe "#Validations" do
    let(:shipment_condition) {FactoryGirl.create(:shipment_condition)}

    it "requires the presence of the shipment_method" do
      shipment_condition.should validate_presence_of :shipment_method
    end

    it "requires the uniqueness of the shipment_method" do
      FactoryGirl.create(:shipment_condition_v2)
      FactoryGirl.build(:shipment_condition_v2).should_not be_valid
    end
    
    describe "value field" do
      it "must be present" do
        shipment_condition.should validate_presence_of :value
      end
      it "must be numerical" do
        shipment_condition.should validate_numericality_of :value
      end
      it "and must be equal or greater than 0" do
        shipment_condition.value.should be_greater_than_or_equal_to 0
      end
    end
  end
end