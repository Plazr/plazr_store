require 'spec_helper'

describe PZS::Search do
  describe ".search" do
    before {FactoryGirl.create_list(:product_full, 5)}
    context "input is not blank" do
      let(:input) { {search: "T-shirt"} }
      it "returns products where only name is similar to the input" do
        FactoryGirl.create(:product_full, :name => "T-shirt")
        PZS::Search.search(input).should have(1).item
      end
      it "returns products where only details is similar to the input" do
        FactoryGirl.create(:product_full, :details => "Great quality garanteed in our t-shirts")
        PZS::Search.search(input).should have(1).item
      end
      it "returns products where name and details are similar to the input" do
        FactoryGirl.create(:product_full, :name => "Championship t-shirt", :details => "Great quality garanteed in our t-shirts")
        PZS::Search.search(input).should have(1).item
      end
      it "returns nothing when name and details aren't similar to the input" do
        PZS::Search.search(input).should have(0).item
      end
    end
    context "input is blank" do
      it "returns all products" do
        input = {search: ""}
        PZS::Search.search(input).should have(5).item
      end
    end
  end
end
