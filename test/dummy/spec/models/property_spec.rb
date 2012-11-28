require 'spec_helper.rb'

describe PZS::Property, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:property).should be_valid
  end

  describe "#Relations" do
    it "has many property_prototypes" do
      FactoryGirl.create(:property).should have_many :property_prototypes
    end

    it "has many prototypes through property_prototypes" do
      FactoryGirl.create(:property).should have_many(:prototypes).through(:property_prototypes)
    end

    it "has many product_properties" do
      FactoryGirl.create(:property).should have_many :product_properties
    end

    it "has many products through product_properties" do
      FactoryGirl.create(:property).should have_many(:products).through(:product_properties)
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a name" do
      FactoryGirl.create(:property).should validate_presence_of :display_name
    end
  end
end