require 'spec_helper'

describe PZS::Prototype, type: :model do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:prototype).should be_valid
  end

  describe "#Relations" do
    it "has many property_prototypes" do
      FactoryGirl.create(:prototype).should have_many(:property_prototypes).dependent(:destroy)
    end
    it "has many properties through property_prototypes" do
      FactoryGirl.create(:prototype).should have_many(:properties).through(:property_prototypes)
    end

    it "has many prototype_variant_properties" do
      FactoryGirl.create(:prototype).should have_many(:prototype_variant_properties).dependent(:destroy)
    end
    it "has many variant_properties through prototype_variant_properties" do
      FactoryGirl.create(:prototype).should have_many(:variant_properties).through(:prototype_variant_properties)
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      FactoryGirl.create(:prototype).should validate_presence_of :name
    end
    it "does not allow duplicate name" do
      FactoryGirl.create(:prototype_v2)
      FactoryGirl.build(:prototype_v2).should_not be_valid
    end
  end

  describe "#Public Methods" do
    describe "#get_unselected_properties_and_order_by_name" do
      it "builds all the properties with the prototype" do
        pr = FactoryGirl.create_list(:property, 2)
        p = FactoryGirl.create(:prototype)
        pr_v2 = FactoryGirl.create(:property_v2)
        # get the result and store it in variable 'res'
        res = p.get_unselected_properties_and_order_by_name
        # clears the prototype's relation created 
        p.reload
        # creates the new relations, by hand, as it was supposed to be created
        p.property_prototypes.build(:property => pr_v2)
        p.property_prototypes.build(:property => pr[0])
        p.property_prototypes.build(:property => pr[1])
        # compares the result of the method called to the new relation created
        res.inspect.should eq p.property_prototypes.inspect
      end
    end
    describe "#get_unselected_variant_properties_and_order_by_name" do
      it "builds all the variant_properties with the prototype" do
        vp = FactoryGirl.create_list(:variant_property, 2)
        p = FactoryGirl.create(:prototype)
        vp_v2 = FactoryGirl.create(:variant_property_v2) 
        # get the result and store it in variable 'res'
        res = p.get_unselected_variant_properties_and_order_by_name
        # clears the prototype's relation created 
        p.reload
        # creates the new relations, by hand, as it was supposed to be created
        p.prototype_variant_properties.build(:variant_property => vp_v2)
        p.prototype_variant_properties.build(:variant_property => vp[0])
        p.prototype_variant_properties.build(:variant_property => vp[1])
        # compares the result of the method called to the new relation created
        res.inspect.should eq p.prototype_variant_properties.inspect
      end
    end
  end
end
