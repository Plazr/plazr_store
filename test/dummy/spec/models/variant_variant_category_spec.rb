require 'spec_helper.rb'

describe PZS::VariantVariantCategory, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:variant_variant_category).should be_valid
  end

  describe "#Relations" do
    it "belongs to a variant" do 
      FactoryGirl.create(:variant_variant_category).should belong_to :variant
    end
    it "belongs to a variant_category" do 
      FactoryGirl.create(:variant_variant_category).should belong_to :variant_category
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a variant" do
      FactoryGirl.create(:variant_variant_category).should validate_presence_of :variant
    end
    it "requires the presence of a variant_category" do
      FactoryGirl.create(:variant_variant_category).should validate_presence_of :variant_category
    end
  end

  describe "#Public Methods" do
    describe "#category_master_variant?(product)" do
      context "the master_variant of the product is associated with the variant_category" do
        it "returns true" do
          vcl = FactoryGirl.create(:variant_category_leaf)
          p = FactoryGirl.create(:product_with_master_variant)
          var = FactoryGirl.create(:variant_not_master, :product => p)
          FactoryGirl.create(:variant_variant_category, :variant_id => p.master_variant.first.id, :variant_category => vcl)
          vvc = FactoryGirl.build(:variant_variant_category, :variant_id => var.id, :variant_category => vcl)
          vvc.category_master_variant?(p).should be_true
        end
      end
      context "the master_variant of the product isn't associated with the variant_category" do
        it "returns false" do
          vvc = FactoryGirl.create(:variant_variant_category)
          vcl = FactoryGirl.create(:variant_category_leaf)
          p = FactoryGirl.create(:product_with_master_variant)
          var = FactoryGirl.create(:variant_not_master, :product => p)
          vvc = FactoryGirl.build(:variant_variant_category, :variant_id => var.id, :variant_category => vcl)
          vvc.category_master_variant?(var.product).should be_false
        end
      end
    end
  end
end
