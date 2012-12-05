require 'spec_helper'

describe PZS::Admin::PrototypesController, :type => :controller, :skip => true do
  # render_views

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
    it "assigns a new prototype to @prototype" do
      controller.stub(:instance_variable_loading)
      get :new
      assigns(:prototype).should be_an_instance_of PZS::Prototype 
    end
    it "renders the :new template" do
      controller.stub(:instance_variable_loading)
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    describe "is filtered by #instance_variable_loading" do
      it_behaves_like 'before filter and assign', :edit, :prototype, [:property, :variant_property]
    end
    it "assigns the requested prototype to @prototype" do
      controller.stub(:instance_variable_loading)
      p = FactoryGirl.create :prototype
      get :edit, id: p
      assigns(:prototype).should eq(p)
    end
    it "renders the :edit template" do
      controller.stub(:instance_variable_loading)
      get :edit, id: FactoryGirl.create(:prototype)
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :prototype, PZS::Prototype
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :prototype, :name
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :prototype, PZS::Prototype
  end
end
