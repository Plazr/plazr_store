require 'spec_helper'

describe PZS::Admin::BrandsController, :type => :controller do
  # render_views

  describe "GET #index" do
    it "assigns brands" do
      brand = FactoryGirl.create :brand
      get :index
      assigns(:brands).should eq([brand])
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it_behaves_like 'assign and render', :show, :brand
  end

  describe "GET #new" do
    it "assigns a new brand to @brand" do
      get :new
      assigns(:brand).should be_an_instance_of PZS::Brand 
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render',  :edit,:brand
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new brand in the database" do
        expect{
          post :create, brand: FactoryGirl.attributes_for(:brand)
        }.to change(PZS::Brand,:count).by(1)
      end
      it "redirects to the :show template" do
        post :create, brand: FactoryGirl.attributes_for(:brand)
        response.should redirect_to admin_brand_url(PZS::Brand.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new brand in the database" do
        expect{
          post :create, brand: FactoryGirl.attributes_for(:invalid_brand)
        }.to_not change(PZS::Brand,:count)
      end
      it "re-renders the :new template" do
        post :create, brand: FactoryGirl.attributes_for(:invalid_brand)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_brand) {FactoryGirl.create(:brand)}

    context "valid attributes" do
      let(:new_brand) { FactoryGirl.attributes_for(:adidas_brand)}
      it "locates the requested brand" do
        put :update, id: existing_brand, brand: new_brand
        assigns(:brand).should eq(existing_brand)      
      end

      it "changes brand's attributes" do
        put :update, id: existing_brand, brand: new_brand
        existing_brand.reload # to check that our updates are actually persisted
        existing_brand.name.should eq(new_brand[:name])
      end

      it "redirects to the updated brand" do
        put :update, id: existing_brand, brand: FactoryGirl.attributes_for(:brand)
        response.should redirect_to admin_brand_url(existing_brand)
      end
    end

    context "invalid attributes" do
      it "locates the requested brand" do
        put :update, id: existing_brand, brand: FactoryGirl.attributes_for(:invalid_brand)
        assigns(:brand).should eq(existing_brand)      
      end

      it "does not change brand's attributes" do
        put :update, id: existing_brand, brand: FactoryGirl.attributes_for(:invalid_brand)
        existing_brand.reload # to check that our updates are actually persisted
        existing_brand.name.should_not be_nil
      end

      it "re-renders the edit method" do
        put :update, id: existing_brand, brand: FactoryGirl.attributes_for(:invalid_brand)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:existing_brand) {FactoryGirl.create(:brand)}

    it "deletes the brand" do
      expect{
        delete :destroy, id: existing_brand
      }.to change(PZS::Brand,:count).by(-1)
    end

    it "marks it as deleted" do
      existing_brand.reload
      expect{
        delete :destroy, id: existing_brand
      }.to change(PZS::Brand.with_deleted, :count).by(0)
    end

    it "redirects to brands#index" do
      delete :destroy, id: existing_brand
      response.should redirect_to admin_brands_path
    end
  end
end
