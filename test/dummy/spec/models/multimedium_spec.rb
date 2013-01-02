require 'spec_helper'

describe PZS::Multimedium, type: :model do

  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:multimedium_for_variant).should be_valid
  end

  describe "#Relations" do
    it "belongs to variant" do 
      FactoryGirl.create(:multimedium_for_variant).should belong_to :variant
    end

    it "belongs to page" do 
      FactoryGirl.create(:multimedium_for_variant).should belong_to :page
    end
  end

  describe "#Validations" do
    it "requires variant to be set" do
      FactoryGirl.create(:multimedium_for_variant).should validate_presence_of :variant
    end
    it "requires page to be set" do
      FactoryGirl.create(:multimedium_for_page).should validate_presence_of :page
    end
    it "requires file to be set" do
      FactoryGirl.create(:multimedium_for_variant).should validate_presence_of :file
    end
  end

  describe "#Public Methods" do
    describe "#page_nil?" do
      context "doesn't have a page" do
        it "returns true" do
          m = FactoryGirl.create(:multimedium_for_variant)
          m.page_nil?.should be_true
        end
      end
      context "has a page" do
        it "returns false" do
          m = FactoryGirl.create(:multimedium_for_page)
          m.page_nil?.should be_false
        end
      end
    end
    describe "#variant_nil?" do
      context "doesn't have a variant" do
        it "returns true" do
          m = FactoryGirl.create(:multimedium_for_page)
          m.variant_nil?.should be_true
        end
      end
      context "has a variant" do
        it "returns false" do
          m = FactoryGirl.create(:multimedium_for_variant)
          m.variant_nil?.should be_false
        end
      end
    end
    describe "#set_path_based_on_parent!" do
      it "has a variant" do
        m = FactoryGirl.create(:multimedium_for_variant)
        m.set_path_based_on_parent!.should eq(":rails_root/public/assets/upload/variants/:id/:style/:basename.:extension")
      end
      it "has a page" do
        m = FactoryGirl.create(:multimedium_for_page)
        m.set_path_based_on_parent!.should eq(":rails_root/public/assets/upload/pages/:id/:style/:basename.:extension")
      end
    end
    describe "#set_url_base_on_parent!" do
      it "has a variant" do
        m = FactoryGirl.create(:multimedium_for_variant)
        m.set_url_base_on_parent!.should eq("/assets/upload/variants/:id/:style/:basename.:extension")
      end
      it "has a page" do
        m = FactoryGirl.create(:multimedium_for_page)
        m.set_url_base_on_parent!.should eq("/assets/upload/pages/:id/:style/:basename.:extension")
      end
    end
    describe "#multimedia_from_all_variants_of_a_product" do
      it "returns all the multimedia associated with the variants of a given product" do
        p = FactoryGirl.create :product
        v = FactoryGirl.create_list(:variant, 2, :product_id => p.id)
        m1 = FactoryGirl.create_list(:multimedium, 5, :variant_id => v[0].id)
        m2 = FactoryGirl.create_list(:multimedium, 5, :variant_id => v[1].id)
        PZS::Multimedium.multimedia_from_all_variants_of_a_product(p).should eq(m1 + m2)
      end
    end
  end
end
