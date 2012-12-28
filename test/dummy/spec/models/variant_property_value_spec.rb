require 'spec_helper.rb'

describe PZS::VariantPropertyValue, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:variant_property_value).should be_valid
  end

  describe "#Relations" do
    it "belongs to a variant_property" do
      FactoryGirl.create(:variant_property_value).should belong_to :variant_property
    end

    it "has many variant_variant_property_values" do
      FactoryGirl.create(:variant_property_value).should have_many(:variant_variant_property_values).dependent(:destroy)
    end

    it "has many variant through variant_variant_property_values" do
      FactoryGirl.create(:variant_property_value).should have_many(:variants).through(:variant_variant_property_values)
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a name" do
      FactoryGirl.create(:variant_property_value).should validate_presence_of :variant_property
    end
    it "does not allow duplicate name" do
      FactoryGirl.create(:variant_property_value_v2)
      FactoryGirl.build(:variant_property_value_v2).should_not be_valid
    end
    it "requires the presence of a name" do
      FactoryGirl.create(:variant_property_value).should validate_presence_of :name
    end
    context "presentation is blank and name isn't" do
      it "becomes the same as name" do
        vpv = FactoryGirl.create(:variant_property_value, :presentation => nil)
        vpv.presentation.should eq vpv.name
      end
    end
  end
end