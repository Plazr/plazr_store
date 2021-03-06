require 'spec_helper'

describe PZS::Admin::PropertiesController, :type => :controller do 
  render_views
  login_admin

  describe "GET #index" do
    it_behaves_like 'default admin index method', :property
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :property
  end

  describe "GET #new" do
    it_behaves_like 'default admin new method', :property, PZS::Property
  end

  describe "GET #edit" do
    it_behaves_like 'default admin show and edit methods', :edit, :property
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :property, PZS::Property
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :property, [:display_name]
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :property, PZS::Property
  end
end
