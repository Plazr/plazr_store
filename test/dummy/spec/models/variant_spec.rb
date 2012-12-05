require 'spec_helper'

describe PZS::Variant, type: :model, skip: true do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:variant).should be_valid
  end

  describe "#Relations" do
    it "belongs to product" do 
      FactoryGirl.create(:variant).should belong_to :product
    end

    it "has many multimedia" do 
      FactoryGirl.create(:variant).should have_many :multimedia
    end

    it "has many promotion_variants" do
      FactoryGirl.create(:variant).should have_many :promotion_variants
    end
    it "has many promotions through promotion_variants" do
      FactoryGirl.create(:variant).should have_many(:promotions).through(:promotion_variants)
    end

    it "has many shipment_condition_variants" do
      FactoryGirl.create(:variant).should have_many :shipment_condition_variants
    end
    it "has many shipment_conditions through shipment_condition_variants" do
      FactoryGirl.create(:variant).should have_many(:shipment_conditions).through(:shipment_condition_variants)
    end

    it "has many variant_property_values" do
      FactoryGirl.create(:variant).should have_many :variant_property_values
    end
    it "has many variant_properties through variant_property_values" do
      FactoryGirl.create(:variant).should have_many(:variant_properties).through(:variant_property_values)
    end

    it "has many variant_variant_categories" do
      FactoryGirl.create(:variant).should have_many :variant_variant_categories
    end
    it "has many variant_categories through variant_variant_categories" do
      FactoryGirl.create(:variant).should have_many(:variant_categories).through(:variant_variant_categories)
    end

    it "has many variant_wishlists" do
      FactoryGirl.create(:variant).should have_many :variant_wishlists
    end
    it "has many wishlists through variant_wishlists" do
      FactoryGirl.create(:variant).should have_many(:wishlists).through(:variant_wishlists)
    end
  end

  describe "#Validations" do
    it "requires sku to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :sku
    end
    it "requires price to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :price
    end
    it "requires available to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :available
    end
    it "requires amount_available to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :amount_available
    end
    it "requires is_master to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :is_master
    end
    it "requires product_id to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :product_id
    end

    it "does not allow duplicate sku" do
      FactoryGirl.create(:variant, sku: "X100")
      FactoryGirl.build(:variant, sku: "X100").should_not be_valid
    end
  end
end
