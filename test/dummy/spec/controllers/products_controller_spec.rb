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
    it "assigns the requested product to @product" do
      m = FactoryGirl.create :product_full
      get :show, id: m
      assigns(:product).should eq(m)
    end

    it "renders the :show template" do
      get :show, id: FactoryGirl.create(:product_full)
      response.should render_template :show
    end
  end
end
