require 'spec_helper'

describe PZS::Prototype, type: :model do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:prototype).should be_valid
  end

  describe "#Relations" do
    it "has many products" do 
      FactoryGirl.create(:prototype).should have_many :products
    end

    it "has many property_prototypes" do
      FactoryGirl.create(:prototype).should have_many :property_prototypes
    end
    it "has many properties through property_prototypes" do
      FactoryGirl.create(:prototype).should have_many(:properties).through(:property_prototypes)
    end

    it "has many prototype_variant_properties" do
      FactoryGirl.create(:prototype).should have_many :prototype_variant_properties
    end
    it "has many variant_properties through prototype_variant_properties" do
      FactoryGirl.create(:prototype).should have_many(:variant_properties).through(:prototype_variant_properties)
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      FactoryGirl.create(:prototype).should validate_presence_of :name
    end
  end
end
