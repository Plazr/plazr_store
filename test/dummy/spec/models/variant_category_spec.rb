require 'spec_helper.rb'

describe PZS::VariantCategory, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:variant_category).should be_valid
  end

  describe "#Relations" do
    it "has many variant_variant_categories" do
      FactoryGirl.create(:variant_category).should have_many :variant_variant_categories
    end

    it "has many variants through variant_variant_categories" do
      FactoryGirl.create(:variant_category).should have_many(:variants).through(:variant_variant_categories)
    end

    it "has many second_variant_categories" do
      FactoryGirl.create(:variant_category).should have_many(:child_variant_categories).class_name("VariantCategory")
    end

    it "belongs to first_variant_category" do
      FactoryGirl.create(:variant_category).should belong_to(:parent_variant_category).class_name("VariantCategory")
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a name" do
      FactoryGirl.create(:variant_category).should validate_presence_of :name
    end
  end
end
