require 'spec_helper.rb'

describe PZS::ProductCategory, :type => :model do

  it "should create a new valid instance" do
    FactoryGirl.create(:product_category).should be_valid
  end

  describe "#Relations" do
    it "has many child_variant_categories" do
      FactoryGirl.create(:product_category).should have_many(:child_product_categories).class_name("ProductCategory").dependent(:destroy)
    end

    it "belongs to parent_product_category" do
      FactoryGirl.create(:product_category).should belong_to(:parent_product_category).class_name("ProductCategory")
    end

    it "has many product_product_categories" do
      FactoryGirl.create(:product_category).should have_many(:product_product_categories).dependent(:destroy)
    end

    it "has many products through product_product_categories" do
      FactoryGirl.create(:product_category).should have_many(:products).through(:product_product_categories)
    end
  end
  
  describe "#Validations" do
    it "requires the presence of a name" do
      FactoryGirl.create(:product_category).should validate_presence_of :name
    end
  end

  describe "#Public Methods" do
    describe "#set_leaf" do
      context "the parent_product_category_id is blank" do
        it "is_leaf is set to false" do
          pc = FactoryGirl.create(:product_category, :parent_product_category_id => nil)
          pc.is_leaf.should be_false
        end
      end
      context "the parent_product_category_id is not blank" do
        it "is_leaf is set to true" do
          pc = FactoryGirl.create(:product_category_leaf)
          pc.is_leaf.should be_true
        end
      end
    end
    describe "#is_child?" do
      context "it is a child category" do
        it "returns true" do
          pc = FactoryGirl.create(:product_category_leaf)
          pc.is_child?.should be_true
        end
      end
      context "it is a parent category" do
        it "returns false" do
          pc = FactoryGirl.create(:product_category)
          pc.is_child?.should be_false
        end
      end
    end
    describe "#self.parent_categories_without(id)" do
      it "returns all the parent_categories minus the one corresponding to the id argument" do
        pc = FactoryGirl.create_list(:product_category, 5)
        pc1 = FactoryGirl.create(:product_category)
        child = FactoryGirl.create(:product_category_leaf)
        PZS::ProductCategory.parent_categories_without(pc1.id).should eq pc << child.parent_product_category
      end
    end
  end
end
