require 'spec_helper.rb'

describe PZS::VariantCategory, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:variant_category).should be_valid
  end

  describe "#Relations" do
    it "has many child_variant_categories" do
      FactoryGirl.create(:variant_category).should have_many(:child_variant_categories).class_name("VariantCategory").dependent(:destroy)
    end

    it "belongs to parent_variant_category" do
      FactoryGirl.create(:variant_category).should belong_to(:parent_variant_category).class_name("VariantCategory")
    end

    it "has many variant_variant_categories" do
      FactoryGirl.create(:variant_category).should have_many(:variant_variant_categories).dependent(:destroy)
    end

    it "has many variants through variant_variant_categories" do
      FactoryGirl.create(:variant_category).should have_many(:variants).through(:variant_variant_categories)
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a name" do
      FactoryGirl.create(:variant_category).should validate_presence_of :name
    end
  end

  describe "#Public Methods" do
    describe "#set_leaf" do
      context "the parent_variant_category_id is blank" do
        it "is_leaf is set to false" do
          vc = FactoryGirl.create(:variant_category, :parent_variant_category_id => nil)
          vc.is_leaf.should be_false
        end
      end
      context "the parent_variant_category_id is not blank" do
        it "is_leaf is set to true" do
          vc = FactoryGirl.create(:variant_category_leaf)
          vc.is_leaf.should be_true
        end
      end
    end
    describe "#is_child?" do
      context "it is a child category" do
        it "returns true" do
          vc = FactoryGirl.create(:variant_category_leaf)
          vc.is_child?.should be_true
        end
      end
      context "it is a parent category" do
        it "returns false" do
          vc = FactoryGirl.create(:variant_category)
          vc.is_child?.should be_false
        end
      end
    end
    describe "#self.parent_categories_without(id)" do
      it "returns all the parent_categories minus the one corresponding to the id argument" do
        vc = FactoryGirl.create_list(:variant_category, 5)
        vc1 = FactoryGirl.create(:variant_category)
        child = FactoryGirl.create(:variant_category_leaf)
        PZS::VariantCategory.parent_categories_without(vc1.id).should eq vc << child.parent_variant_category
      end
    end
  end
end
