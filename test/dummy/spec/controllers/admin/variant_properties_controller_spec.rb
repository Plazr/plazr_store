require 'spec_helper'

describe PZS::Admin::VariantPropertiesController, :type => :controller do 
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :variant_property
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :variant_property
  end

  describe "GET #new" do
    it_behaves_like 'default admin new method', :variant_property, PZS::VariantProperty
  end

  describe "GET #edit" do
    it_behaves_like 'default admin show and edit methods', :edit, :variant_property
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :variant_property, PZS::VariantProperty
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :variant_property, :display_name
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :variant_property, PZS::VariantProperty
  end
end
