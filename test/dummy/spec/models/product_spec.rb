require 'spec_helper'

describe PZS::Product, type: :model, focus: true do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:product).should be_valid
  end

  describe "#Relations" do
    it "belongs to brand" do 
      FactoryGirl.create(:product).should belong_to :brand
    end

    it "belongs to prototype" do 
      FactoryGirl.create(:product).should belong_to :prototype
    end

    it "has many feedback_products" do 
      FactoryGirl.create(:product).should have_many :feedback_products
    end

    it "has many product_properties" do
      FactoryGirl.create(:product).should have_many :product_properties
    end
    it "has many properties through product_properties" do
      FactoryGirl.create(:product).should have_many(:properties).through(:product_properties)
    end

    it "has many product_variant_properties" do
      FactoryGirl.create(:product).should have_many :product_variant_properties
    end
    it "has many variant_properties through product_variant_properties" do
      FactoryGirl.create(:product).should have_many(:variant_properties).through(:product_variant_properties)
    end

    it "has many variants, :dependent => :destroy" do 
      FactoryGirl.create(:product).should have_many(:variants).dependent(:destroy)
      # TODO falta testar o :inverse_of => :product
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      FactoryGirl.create(:product).should validate_presence_of :name
    end
    it "does not allow duplicate name" do
      FactoryGirl.create(:product_v2)
      FactoryGirl.build(:product_v2).should_not be_valid
    end
    it "does not allow duplicate slug" do
      FactoryGirl.create(:product_v2)
      FactoryGirl.build(:product_v2).should_not be_valid
    end
  end

  describe "#Public Methods" do
    describe "#has_master?" do
      context "has variants" do
        it "returns true" do
          p = FactoryGirl.create(:product_with_master_variant)
          p.has_master?.should be_true
        end
      end
      context "doesn't have variants" do
        it "returns false" do
          p = FactoryGirl.create(:product)
          p.has_master?.should be_false
        end
      end
    end
    describe "#master_variant" do
      it "calls master_variant in Variant" do
        p = FactoryGirl.create(:product_with_master_variant)
        PZS::Variant.should_receive(:master_variant).and_return(p.variants.where(:is_master => true))
        p.master_variant
      end
      it "returns the master variant" do
        # nao sei se este teste está bem feito
        p = FactoryGirl.create(:product_with_master_variant)
        PZS::Variant.stub(:master_variant).and_return(p.variants.where(:is_master => true))
        p.master_variant.should eq [p.variants.first]
      end
    end
  end
end
