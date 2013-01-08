require 'spec_helper.rb'

describe PZS::Property, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:property).should be_valid
  end

  describe "#Relations" do
    it "has many product_properties" do
      FactoryGirl.create(:property).should have_many(:product_properties).dependent(:destroy)
    end

    it "has many products through product_properties" do
      FactoryGirl.create(:property).should have_many(:products).through(:product_properties)
    end
    it "has many property_prototypes" do
      FactoryGirl.create(:property).should have_many(:property_prototypes).dependent(:destroy)
    end

    it "has many prototypes through property_prototypes" do
      FactoryGirl.create(:property).should have_many(:prototypes).through(:property_prototypes)
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a id_name" do
      FactoryGirl.create(:property).should validate_presence_of :id_name
    end
    it "does not allow duplicate id_name" do
      FactoryGirl.create(:property_v2)
      FactoryGirl.build(:property_v2).should_not be_valid
    end
    context "display_name is blank and id_name isn't" do
      it "becomes the same as id_name" do
        p = FactoryGirl.create(:property, :display_name => nil)
        p.display_name.should eq p.id_name
      end
    end
  end
end
