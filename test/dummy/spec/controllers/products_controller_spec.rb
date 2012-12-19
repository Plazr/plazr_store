require 'spec_helper'

describe PZS::ProductsController, :type => :controller do
  render_views

  describe "GET #index" do
    it "assigns products" do
      m = FactoryGirl.create :product_full
      get :index
      assigns(:products).should eq([m])
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :product
  end
end
