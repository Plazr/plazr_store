require 'spec_helper'

describe PZS::Admin::VariantsController, :type => :controller do
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :variant
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :variant
  end

  describe "GET #new" do
    it "assigns all products to @products" do
      m = FactoryGirl.create_list(:product, 5)
      get :new
      assigns(:products).should eq(m)
    end
    it "assigns a new variant to @variant" do
      get :new
      assigns(:variant).should be_an_instance_of PZS::Variant 
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns all products to @products" do
      m = FactoryGirl.create_list(:product, 5)
      get :new
      assigns(:products).should eq(m)
    end
    it "assigns the requested variant to @variant" do
      p = FactoryGirl.create :variant
      get :edit, id: p
      assigns(:variant).should eq(p)
    end
    it "renders the :edit template" do
      get :edit, id: FactoryGirl.create(:variant)
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :variant, PZS::Variant
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :variant, [:sku, :price, :available, :is_master, :product], :sku
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :variant, PZS::Variant
  end
end
