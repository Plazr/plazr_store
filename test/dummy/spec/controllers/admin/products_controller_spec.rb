require 'spec_helper'

describe PZS::Admin::ProductsController, :type => :controller do
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :product
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :product
  end

  describe "GET #new" do
    describe "is filtered by #instance_variable_loading" do
      it_behaves_like 'before filter and assign', :new, :product, [:property, :variant_property]
    end
    it "assigns a new product to @product" do
      # PZS::Property.stub( :all ).and_return( FactoryGirl.create :property )
      # PZS::VariantProperty.stub( :all ).and_return( FactoryGirl.create :variant_property )
      # controller.stub(:instance_variable_loading)
      get :new
      assigns(:product).should be_an_instance_of PZS::Product 
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    describe "is filtered by #instance_variable_loading" do
      it_behaves_like 'before filter and assign', :edit, :product, [:property, :variant_property]
    end
    it "assigns the requested product to @product" do
      p = FactoryGirl.create :product
      get :edit, id: p
      assigns(:product).should eq(p)
    end
    it "renders the :edit template" do
      get :edit, id: FactoryGirl.create(:product)
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :product, PZS::Product
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :product, [:name]
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :product, PZS::Product
  end
end
