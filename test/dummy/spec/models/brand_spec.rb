require 'spec_helper'

describe PZS::Brand, type: :model do
  subject(:brand) { FactoryGirl.build :brand }

  it "creates a new instance given a valid attribute" do
    should be_valid
  end

  describe "#Relations" do
    it "has many products" do 
      should have_many :products
    end
  end

  describe "#Validations" do
    it "requires name to be set" do
      should validate_presence_of :name
    end
  end
end
