require 'spec_helper'

describe PZS::Cart, type: :model do

  before :each do
    @cart = FactoryGirl.create(:cart)
  end
  
  describe 'create' do
    it "creates a new instance given a valid attribute" do
      @cart.should be_valid
    end
  end

  describe "#Relations" do
    it "has one order" do
      @cart.should have_one(:order)
    end

    it "has many cart_variants" do 
      @cart.should have_many :cart_variants
    end

    it "has many variants" do
      @cart.should have_many(:variants).through(:cart_variants)
    end

    it "belongs to a user (fake relation)" do
      @cart.user.should_not be_nil  
    end
  end

  describe "#Validations" do
    it "requires user to be set" do
      @cart.should validate_presence_of :user_id
    end
  end

end
