require 'spec_helper'

describe PZS::Admin::BrandsController, :type => :controller, :skip => true do
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :brand
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :brand
  end

  describe "GET #new" do
    it_behaves_like 'default admin new method', :brand, PZS::Brand
  end

  describe "GET #edit" do
    it_behaves_like 'default admin show and edit methods', :edit, :brand
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :brand, PZS::Brand
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :brand, :name
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :brand, PZS::Brand
  end
end
