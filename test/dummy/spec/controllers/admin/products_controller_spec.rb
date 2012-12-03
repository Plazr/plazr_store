require 'spec_helper'

describe PZS::Admin::ProductsController, :type => :controller do
  # render_views

  describe "GET #index" do
    it_behaves_like 'assign and render for index', :product
  end

  describe "GET #show" do
    it_behaves_like 'assign and render for show and edit', :show, :product
  end

  describe "GET #new" do
    # describe "is filtered by #instance_variable_loading" do
    #   it_behaves_like 'before filter and assign', :new, :product, [:property, :variant_property]
    # end
    it "assigns a new product to @product" do
      # controller.stub(:instance_variable_loading)
      get :new
      assigns(:product).should be_an_instance_of PZS::Product 
    end
    it "renders the :new template" do
      # controller.stub(:instance_variable_loading)
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    # describe "is filtered by #instance_variable_loading" do
    #   it_behaves_like 'before filter and assign', :edit, :product, [:property, :variant_property]
    # end
    it "assigns the requested product to @product" do
      # controller.stub(:instance_variable_loading)
      p = FactoryGirl.create :product
      get :edit, id: p
      assigns(:product).should eq(p)
    end
    it "renders the :edit template" do
      # controller.stub(:instance_variable_loading)
      get :edit, id: FactoryGirl.create(:product)
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new product in the database" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product)
        }.to change(PZS::Product,:count).by(1)
      end
      it "redirects to the :show template" do
        post :create, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to admin_product_url(PZS::Product.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new product in the database" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:invalid_product)
        }.to_not change(PZS::Product,:count)
      end
      it "re-renders the :new template" do
        post :create, product: FactoryGirl.attributes_for(:invalid_product)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_product) {FactoryGirl.create(:pes_2012_product)}
    let(:new_name) {"PES 2013"}

    context "valid attributes" do
      it "locates the requested product" do
        put :update, id: existing_product, product: FactoryGirl.attributes_for(:product)
        assigns(:product).should eq(existing_product)      
      end

      it "changes product's attributes" do
        put :update, id: existing_product, product: FactoryGirl.attributes_for(:product, name: new_name)
        existing_product.reload # to check that our updates are actually persisted
        existing_product.name.should eq(new_name)
      end

      it "redirects to the updated product" do
        put :update, id: existing_product, product: FactoryGirl.attributes_for(:product, name: new_name)
        response.should redirect_to admin_product_url(existing_product)
      end
    end

    context "invalid attributes" do
      it "locates the requested product" do
        put :update, id: existing_product, product: FactoryGirl.attributes_for(:invalid_product)
        assigns(:product).should eq(existing_product)      
      end

      it "does not change product's attributes" do
        put :update, id: existing_product, product: FactoryGirl.attributes_for(:invalid_product)
        existing_product.reload # to check that our updates are actually persisted
        existing_product.name.should_not be_nil
      end

      it "re-renders the edit method" do
        put :update, id: existing_product, product: FactoryGirl.attributes_for(:invalid_product)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'admin destroy', :product, PZS::Product
  end
end
