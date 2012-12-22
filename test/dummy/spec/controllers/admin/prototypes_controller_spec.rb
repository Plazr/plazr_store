require 'spec_helper'

describe PZS::Admin::PrototypesController, :type => :controller do
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :prototype
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :prototype
  end

  describe "GET #new" do
    describe "is filtered by #instance_variable_loading" do
      it_behaves_like 'before filter and assign', :new, :prototype, [:property, :variant_property]
    end
    it_behaves_like 'default admin new method', :prototype, PZS::Prototype
  end

  describe "GET #edit" do
    describe "is filtered by #instance_variable_loading" do
      it_behaves_like 'before filter and assign', :edit, :prototype, [:property, :variant_property]
    end
    it_behaves_like 'default admin show and edit methods', :edit, :prototype
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :prototype, PZS::Prototype
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :prototype, [:name]
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :prototype, PZS::Prototype
  end
end
