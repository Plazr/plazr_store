require 'spec_helper.rb'

describe PZS::VariantProperty, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:variant_property).should be_valid
  end

  describe "#Relations" do
    it "has many product_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many :product_variant_properties
    end

    it "has many products through product_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many(:products).through(:product_variant_properties)
    end

    it "has many prototype_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many :prototype_variant_properties
    end

    it "has many prototypes through prototype_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many(:prototypes).through(:prototype_variant_properties)
    end

    it "has many variant_property_values" do
      FactoryGirl.create(:variant_property).should have_many :variant_property_values
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a name" do
      FactoryGirl.create(:variant_property).should validate_presence_of :display_name
    end
  end
end