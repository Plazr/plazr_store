require 'spec_helper'

describe PZS::SearchController, :type => :controller do
  render_views

  describe "GET #search" do
    let(:input) { {search: "t-shirt"} }
    it "assigns products" do
      FactoryGirl.create_list :product_full, 5
      m = FactoryGirl.create :product_full, :name => "Championship #{input[:search].capitalize}"
      PZS::Search.stub(:search).and_return([m])
      get :search, input
      assigns(:products).should eq([m])
    end
  end
end
