require 'spec_helper'

describe PZS::Admin::PagesController, :type => :controller do 
  #render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :page
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :page
  end

  describe "GET #new" do
    it_behaves_like 'default admin new method', :page, PZS::Page
  end

  describe "GET #edit" do
    it_behaves_like 'default admin show and edit methods', :edit, :page
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :page, PZS::Page
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :page, [:title], :title
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :page, PZS::Page
  end
end
