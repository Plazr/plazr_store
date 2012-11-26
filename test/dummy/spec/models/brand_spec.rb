require 'spec_helper'

describe PZS::Brand, type: :model do
  subject(:brand) { FactoryGirl.build :brand }

  it "creates a new instance given a valid attribute" do
    should be_valid
  end

  describe "#Relations" do
    it { should have_many :products }
  end

  describe "#Validations" do
    it { should validate_presence_of :name }
  end
end
