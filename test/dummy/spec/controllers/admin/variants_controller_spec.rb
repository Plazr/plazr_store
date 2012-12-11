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
      p = FactoryGirl.create(:product_with_master_variant)
      get :new
      assigns(:products).should eq([p])
    end
    it_behaves_like 'default admin new method', :variant, PZS::Variant
  end

  describe "GET #edit" do
    it "assigns all products to @products" do
      p = FactoryGirl.create(:product_with_master_variant)
      get :edit, id: p.master_variant.first # master_variant returns an ActiveRecord::Relation object
      assigns(:products).should eq([p])
    end
    it_behaves_like 'default admin show and edit methods', :edit, :variant
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :variant, PZS::Variant
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :variant, [:sku, :price, :available, :is_master, :product_id]
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :variant, PZS::Variant
  end
end
