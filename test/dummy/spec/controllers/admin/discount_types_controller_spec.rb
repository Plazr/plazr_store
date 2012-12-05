require 'spec_helper'

describe PZS::Admin::DiscountTypesController, :type => :controller, :skip => true do 
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :discount_type
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :discount_type
  end

  describe "GET #new" do
    it_behaves_like 'default admin new method', :discount_type, PZS::DiscountType
  end

  describe "GET #edit" do
    it_behaves_like 'default admin show and edit methods', :edit, :discount_type
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :discount_type, PZS::DiscountType
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :discount_type, [:name], :name
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :discount_type, PZS::DiscountType
  end
end
