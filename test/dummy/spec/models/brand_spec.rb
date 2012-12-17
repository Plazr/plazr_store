require 'spec_helper'

describe PZS::Brand, type: :model do
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:brand).should be_valid
  end

  describe "#Relations" do
    it "has many products" do 
      FactoryGirl.create(:brand).should have_many :products
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      FactoryGirl.create(:brand).should validate_presence_of :name
    end
  end
end
