require 'spec_helper'

describe PZS::Prototype, type: :model do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:prototype).should be_valid
  end

  describe "#Relations" do
    it "has many products" do 
      FactoryGirl.create(:prototype).should have_many :products
    end
    xit "has and belongs to many properties" do
      should have_and_belong_to_many(:properties)
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      FactoryGirl.create(:prototype).should validate_presence_of :name
    end
  end
end
