require 'spec_helper'

describe PZS::Admin::ProductsController, :type => :controller do
  render_views
  login_admin

  describe "GET #index" do
    it_behaves_like 'default admin index method', :product
  end

  describe "GET #show", focus: true do
    it_behaves_like 'default admin show and edit methods', :show, :product
  end

  describe "GET #new" do
    it "assigns a new product to @product" do
      get :new
      assigns(:product).should be_an_instance_of PZS::Product 
    end
    it "builds a new product's variant" do
      get :new
      assigns(:product).variants.should be_present
    end
    xit "calls @product.get_unselected_variant_properties_and_order_by_name" do
      p = FactoryGirl.build(:product)
      vp = FactoryGirl.create_list(:variant_property, 2)
      p.product_variant_properties.build(:variant_property => vp[0])
      p.product_variant_properties.build(:variant_property => vp[1])
      p.should_receive(:get_unselected_variant_properties_and_order_by_name).and_return(p.product_variant_properties)
      get :new
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    # describe "is filtered by #instance_variable_loading" do
    #   it_behaves_like 'before filter and assign', :edit, :product, [:property, :variant_property]
    # end
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

  #describe "POST #create" do
  #  it_behaves_like 'default admin create method', :product, PZS::Product
  #end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :product, [:name]
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :product, PZS::Product
  end
end
