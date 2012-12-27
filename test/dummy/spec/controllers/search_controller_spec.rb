require 'spec_helper'

describe PZS::SearchController, :type => :controller do
  render_views

  describe "GET #search" do
    let(:input) {"t-shirt"}
    it "assigns products" do
      FactoryGirl.create_list :product_full, 5
      m = FactoryGirl.create :product_full, :name => "Championship #{input.capitalize}"
      PZS::Search.stub(:search).with(input).and_return([m])
      get :search, :search => input
      assigns(:products).should eq([m])
    end
  end
end
