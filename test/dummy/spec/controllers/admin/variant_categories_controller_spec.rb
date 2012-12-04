require 'spec_helper'

describe PZS::Admin::VariantCategoriesController, :type => :controller do 
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :variant_category
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :variant_category
  end

  describe "GET #new" do
    it "assigns all variant_categories to @variant_categories" do
      m = FactoryGirl.create_list(:variant_category, 5)
      get :new
      assigns(:variant_categories).should eq(m)
    end
    it "assigns a new variant_category to @variant_category" do
      get :new
      assigns(:variant_category).should be_an_instance_of PZS::VariantCategory 
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns all variant_categories except the one to be edited to @variant_categories" do
      m = FactoryGirl.create_list(:variant_category, 5)
      n = FactoryGirl.create :variant_category
      get :edit, id: n
      PZS::VariantCategory.stub(:where).and_return(m)
      assigns(:variant_categories).should eq(m)
    end
    it "assigns the requested variant_category to @variant_category" do
      p = FactoryGirl.create :variant_category
      get :edit, id: p
      assigns(:variant_category).should eq(p)
    end
    it "renders the :edit template" do
      get :edit, id: FactoryGirl.create(:variant_category)
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :variant_category, PZS::VariantCategory
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :variant_category, :name
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :variant_category, PZS::VariantCategory
  end
end
