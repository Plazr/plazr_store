require 'spec_helper'

describe PZS::Page, :type => :model do
    
  it "creates a new instance given a valid attribute" do
    FactoryGirl.create(:page).should be_valid
  end

  describe "#Relations" do
    it "has many multimedia" do
      FactoryGirl.create(:page).should have_many :multimedia 
    end
  end

  describe "#Validations" do
    it "requires the presence of a title" do
      FactoryGirl.create(:page).should validate_presence_of :title
    end
    it "does not allow duplicate slug" do
      FactoryGirl.create(:page, slug: "page-x")
      FactoryGirl.build(:page, slug: "page-x").should_not be_valid
    end
  end
end