require 'spec_helper.rb'

describe PZS::VariantProperty, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:variant_property).should be_valid
  end

  describe "#Relations" do
    it "has many product_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many(:product_variant_properties).dependent(:destroy)
    end

    it "has many products through product_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many(:products).through(:product_variant_properties)
    end

    it "has many prototype_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many(:prototype_variant_properties).dependent(:destroy)
    end

    it "has many prototypes through prototype_variant_properties" do
      FactoryGirl.create(:variant_property).should have_many(:prototypes).through(:prototype_variant_properties)
    end

    it "has many variant_property_values" do
      FactoryGirl.create(:variant_property).should have_many(:variant_property_values).dependent(:destroy)
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a id_name" do
      FactoryGirl.create(:variant_property).should validate_presence_of :id_name
    end
    it "does not allow duplicate id_name" do
      FactoryGirl.create(:variant_property_v2)
      FactoryGirl.build(:variant_property_v2).should_not be_valid
    end
    context "display_name is blank and id_name isn't" do
      it "becomes the same as id_name" do
        vp = FactoryGirl.create(:variant_property, :display_name => nil)
        vp.display_name.should eq vp.id_name
      end
    end
  end
end