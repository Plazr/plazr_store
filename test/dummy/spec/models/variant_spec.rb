require 'spec_helper'
require 'spec_support'

describe PZS::Variant, type: :model do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:variant).should be_valid
  end

  describe "#Relations" do
    it "belongs to product" do 
      FactoryGirl.create(:variant).should belong_to :product
    end

    it "has many cart_variants" do
      FactoryGirl.create(:variant).should have_many :cart_variants
    end
    it "has many carts through cart_variants" do
      FactoryGirl.create(:variant).should have_many(:carts).through(:cart_variants)
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
    it "requires available to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :available
    end
    it "requires product_id to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :product
    end
    
    describe "is_master field" do
      let(:variant) {FactoryGirl.create(:variant)}
      it "can take the value 'true'" do
        variant.should allow_value("true").for(:is_master)
      end
      it "can take the value 'false" do
        variant.should allow_value("false").for(:is_master)
      end
      it "cannot take any other value" do
        variant.should_not allow_value(nil).for(:is_master)
      end
    end

    it "does not allow duplicate sku" do
      FactoryGirl.create(:variant_v2)
      FactoryGirl.build(:variant_v2).should_not be_valid
    end
    
    describe "price field" do
      let(:variant) {FactoryGirl.create(:variant)}
      it "must be present" do
        variant.should validate_presence_of :price
      end
      it "must be numerical" do
        variant.should validate_numericality_of :price
      end
      it "and must be equal or greater than 0" do
        variant.price.should be_greater_than_or_equal_to 0
      end
    end
    
    describe "amount_available field" do
      let(:variant) {FactoryGirl.create(:variant)}
      it "must be numerical and only have integer values" do
        variant.should validate_numericality_of(:amount_available).only_integer
      end
    end
    
    describe "cost_price field" do
      let(:variant) {FactoryGirl.create(:variant)}
      it "must be numerical" do
        variant.should validate_numericality_of :price
      end
      it "and must be equal or greater than 0" do
        variant.cost_price.should be_nil_or_greater_than_or_equal_to 0
      end
    end
  end
end
