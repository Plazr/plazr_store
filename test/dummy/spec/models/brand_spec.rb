require 'spec_helper'

describe PZS::Brand do
  # before { @brand = FactoryGirl.build :brand }
  # subject(:brand) { @brand }

  subject(:brand) { FactoryGirl.build :brand }

  it "should create a new instance given a valid attribute" do
    should be_valid
  end

  context "#Relations" do
    it { should have_many :products }
  end

  context "#Validations" do
    it { should validate_presence_of :name }
  end
end
