require 'spec_helper'

describe PZS::Search do
  describe ".search" do
    before {FactoryGirl.create_list(:product_full, 5)}
    context "input is not blank" do
      let(:input) { {search: "T-shirt"} }

      context "no filters" do
        it "returns products when only name is similar to the input" do
          FactoryGirl.create(:product_full, :name => "T-shirt")
          PZS::Search.search(input).should have(1).item
        end
        it "returns products when only details is similar to the input" do
          FactoryGirl.create(:product_full, :details => "Great quality garanteed in our t-shirts")
          PZS::Search.search(input).should have(1).item
        end
        it "returns products when name and details are similar to the input" do
          FactoryGirl.create(:product_full, :name => "Championship t-shirt", :details => "Great quality garanteed in our t-shirts")
          PZS::Search.search(input).should have(1).item
        end
        it "returns nothing when name and details aren't similar to the input" do
          PZS::Search.search(input).should have(0).item
        end
      end

      # TODO examples para os filtros
      context "product_category is filtered" do
        let(:cat_parent) {FactoryGirl.create(:product_category, name: "Clothes")}
        let(:cat_child) {FactoryGirl.create(:product_category, name: "Casual", is_leaf: true, parent_product_category_id: cat_parent.id)}

        context "category selected is a parent category" do
          xit "returns products when a child category of the one selected is associated" do
            p = FactoryGirl.create(:product_with_master_variant)
            p.product_categories << cat_child
            input[:category] = cat_parent.id
            input[:min_price] = 0
            input[:max_price] = 0
            input[:brand] = ""
            input[:price] = ""
            # input.reload
            # puts PZS::ProductCategory.all.inspect
            # puts input.inspect
            # puts PZS::Search.search(input)
            PZS::Search.search(input).should have(1).item
          end
        end
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
