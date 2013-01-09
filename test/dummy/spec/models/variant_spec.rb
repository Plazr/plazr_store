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
      FactoryGirl.create(:variant).should have_many(:multimedia).dependent(:destroy)
    end

    #it "has many shipment_condition_variants" do
    #  FactoryGirl.create(:variant).should have_many(:shipment_condition_variants).dependent(:destroy)
    #end
    
    #it "has many shipment_conditions through shipment_condition_variants" do
    #  FactoryGirl.create(:variant).should have_many(:shipment_conditions).through(:shipment_condition_variants)
    #end

    it "has many variant_variant_property_values" do
      FactoryGirl.create(:variant).should have_many(:variant_variant_property_values).dependent(:destroy)
    end
    it "has many variant_property_values through variant_variant_property_values" do
      FactoryGirl.create(:variant).should have_many(:variant_property_values).through(:variant_variant_property_values)
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
    it "requires visible to be set" do
      FactoryGirl.create(:variant).should validate_presence_of :visible
    end
    it "requires product to be set", focus: true do
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
      it "is present" do
        variant.should validate_presence_of :price
      end
      it "is numerical" do
        variant.should validate_numericality_of :price
      end
      it "is equal or greater than 0" do
        variant.price.should be_greater_than_or_equal_to 0
      end
    end

    describe "amount_available field" do
      let(:variant) {FactoryGirl.create(:variant)}
      it "is numerical and has only integer values" do
        variant.should validate_numericality_of(:amount_available).only_integer
      end
      it "is equal or greater than 0" do
        variant.amount_available.should be_greater_than_or_equal_to 0
      end
    end

    describe "cost_price field" do
      let(:variant) {FactoryGirl.create(:variant)}
      it "is numerical" do
        variant.should validate_numericality_of :price
      end
      it "is equal or greater than 0" do
        variant.cost_price.should be_nil_or_greater_than_or_equal_to 0
      end
    end
  end

  describe "#Callbacks" do
    describe "when the record is being created and it is validated" do
      it "calls set_is_master" do
        v = FactoryGirl.build(:variant) 
        v.should_receive(:set_is_master)
        v.valid?
      end
      context "product already has a master variant" do
        it "sets is_master to false" do
          p = FactoryGirl.create(:product_with_master_variant)
          v = FactoryGirl.build(:variant, product: p) 
          v.valid?
          v.is_master.should be_false
        end
      end
      context "product doesn't have a master variant" do
        it "sets is_master to true" do
          v = FactoryGirl.build(:variant) 
          v.valid?
          v.is_master.should be_true
        end
      end
    end
  end

  describe "#Public Methods" do
    describe "#get_variant_properties_from_product" do
      it "builds all variant_variant_property_values associated with product_variant_properties
          of the product to which this variant belongs to" do 
        #creates a product with master_variant and another variant and two variant_properties associated
        # with the product and variant_property_values for this variant_properties
        p = FactoryGirl.create(:product_with_properties_and_variant_properties)
        var = FactoryGirl.create(:variant, :product_id => p.id)
        vp = FactoryGirl.create(:variant_property_with_values)
        FactoryGirl.create(:product_variant_property, :product_id => p.id, :variant_property => vp)
        # calls the method, store the result in a variable and clears the array
        var.get_variant_properties_from_product
        res = var.variant_variant_property_values
        var.reload
        # build the association, by hand, as it is supposed to be and compare both results
        var.variant_variant_property_values.build(:variant_property_value => p.variant_properties.first.variant_property_values.first)
        var.variant_variant_property_values.build(:variant_property_value => p.variant_properties.second.variant_property_values.first)
        res.inspect.should eq var.variant_variant_property_values.inspect
      end
    end
    describe "#variant_description" do
      context "it is called by the master_variant" do
        it "returns the string 'All'" do 
          v = FactoryGirl.create(:variant)
          v.variant_description.should eq 'All'
        end
      end
      context "it is called by a variant that is not master" do
        it "returns a string with information about all the variant_properties associated" do
          p = FactoryGirl.create(:product_with_master_variant)
          v = FactoryGirl.create(:variant_with_variant_property_values, :product_id => p.id)
          #create string, by hand, as it is supposed to return
          v.variant_description.should eq v.variant_variant_property_values.first.variant_property_value.variant_property.id_name << 
            ": " << v.variant_variant_property_values.first.variant_property_value.name
        end
      end
    end
  end
end
