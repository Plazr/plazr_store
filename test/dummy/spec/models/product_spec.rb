require 'spec_helper'

describe PZS::Product, type: :model do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:product).should be_valid
  end

  describe "#Relations" do
    it "belongs to brand" do 
      FactoryGirl.create(:product).should belong_to :brand
    end

    it "has many feedback_products" do 
      FactoryGirl.create(:product).should have_many :feedback_products
    end

    it "has many product_promotions" do
      FactoryGirl.create(:product).should have_many(:product_promotions).dependent(:destroy)
    end
    it "has many promotions through product_promotions" do
      FactoryGirl.create(:product).should have_many(:promotions).through(:product_promotions)
    end

    it "has many product_properties" do
      FactoryGirl.create(:product).should have_many(:product_properties).dependent(:destroy)
    end
    it "has many properties through product_properties" do
      FactoryGirl.create(:product).should have_many(:properties).through(:product_properties)
    end

    it "has many product_product_categories" do
      FactoryGirl.create(:product).should have_many(:product_product_categories).dependent(:destroy)
    end
    it "has many product_categories through product_product_categories" do
      FactoryGirl.create(:product).should have_many(:product_categories).through(:product_product_categories)
    end

    it "has many product_variant_properties" do
      FactoryGirl.create(:product).should have_many(:product_variant_properties).dependent(:destroy)
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
    # deprecated. slug is now automatically set, so this test would fail
    #it "requires slug to be set" do
    #  FactoryGirl.create(:product).should validate_presence_of :slug
    #end
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
      # it "calls master_variant in Variant" do
      #   p = FactoryGirl.create(:product_with_master_variant)
      #   PZS::Variant.should_receive(:master_variant).and_return(p.variants.where(:is_master => true))
      #   p.master_variant
      # end
      it "returns the master variant" do
        # nao sei se este teste está bem feito
        p = FactoryGirl.create(:product_with_master_variant)
        # PZS::Variant.stub(:master_variant).and_return(p.variants.where(:is_master => true))
        p.master_variant.should eq p.variants.first
        # p.master_variant.should eq [p.variants.first]
      end
    end
    describe "#master_price" do
      it "returns the price of the master_variant" do
        p = FactoryGirl.create(:product_with_master_variant)
        p.master_price.should eq PZS::Variant.where(:product_id => p.id, :is_master => true).first.price
      end
    end
    describe "#variants_without_master" do
      it "returns all the variants of a product except for the master_variant" do
        p = FactoryGirl.create(:product_with_master_variant)
        varl = FactoryGirl.create_list(:variant_not_master, 5, :product_id => p.id)
        p.variants_without_master.should eq varl
      end
    end
    describe "#has_variants?" do
      context "the product has variants" do
        it "returns true" do
          p = FactoryGirl.create(:product_with_master_variant)
          FactoryGirl.create_list(:variant_not_master, 5, :product_id => p.id)
          p.has_variants?.should be_true
        end
      end
      context "the product has no variants" do
        it "returns false" do
          p = FactoryGirl.create(:product_with_master_variant)
          p.has_variants?.should be_false
        end
      end
    end
    describe "#get_unselected_product_categories_and_order_by_name" do
      it "builds product_product_categories" do 
        pc = FactoryGirl.create_list(:product_category, 2)
        pcc = FactoryGirl.create(:product_category_leaf)
        p = FactoryGirl.create(:product)
        p.get_unselected_product_categories_and_order_by_name
        res = p.product_product_categories
        p.reload
        p.product_product_categories.build(:product_category => pc[0])
        p.product_product_categories.build(:product_category => pc[1])
        p.product_product_categories.build(:product_category => pcc.parent_product_category)
        p.product_product_categories.build(:product_category => pcc)
        res.inspect.should eq p.product_product_categories.inspect
      end
    end
    describe "#get_unselected_variant_properties_and_order_by_name" do
      it "builds product_properties" do 
        vp = FactoryGirl.create_list(:variant_property, 2)
        p = FactoryGirl.create(:product)
        res = p.get_unselected_variant_properties_and_order_by_name
        p.reload
        p.product_variant_properties.build(:variant_property => vp[0])
        p.product_variant_properties.build(:variant_property => vp[1])
        res.inspect.should eq p.product_variant_properties.inspect
      end
    end
    describe "#create_all_properties_association(prototype_id)" do
      it "duplicate all the PropertyPrototype associations to ProductProperty" do
        p = FactoryGirl.create(:product)
        prot = FactoryGirl.create(:prototype_with_properties_and_variant_properties)
        p.create_all_properties_association(prot.id)
        p.properties.should eq prot.properties
      end
    end
    describe "#create_all_variant_properties_association(prototype_id)" do
      it "duplicate all the PrototypeVariantProperty associations to ProductVariantProperty" do
        p = FactoryGirl.create(:product)
        prot = FactoryGirl.create(:prototype_with_properties_and_variant_properties)
        p.create_all_variant_properties_association(prot.id)
        p.variant_properties.should eq prot.variant_properties
      end
    end
  end
end
