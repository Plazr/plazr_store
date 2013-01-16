require 'spec_helper'

describe PZS::Multimedium, type: :model do

  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:multimedium_for_variant).should be_valid
  end

  describe "#Relations" do
    it "belongs to variant" do 
      FactoryGirl.create(:multimedium_for_variant).should belong_to :variant
    end
  end

  describe "#Validations" do
    it "requires file to be set" do
      FactoryGirl.create(:multimedium_for_variant).should validate_presence_of :file
    end
  end

  describe "#Public Methods" do
    describe "#set_path_based_on_parent!" do
      it "has a variant" do
        m = FactoryGirl.create(:multimedium_for_variant)
        m.set_path_based_on_parent!.should eq(":rails_root/public/assets/upload/variants/:id/:style/:basename.:extension")
      end
    end
    describe "#set_url_base_on_parent!" do
      it "has a variant" do
        m = FactoryGirl.create(:multimedium_for_variant)
        m.set_url_base_on_parent!.should eq("/assets/upload/variants/:id/:style/:basename.:extension")
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
