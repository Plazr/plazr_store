require 'spec_helper'

describe PZS::Admin::VariantPropertiesController, :type => :controller do 
  #render_views

  describe "GET #index" do
    it "assigns variant_property" do
      variant_property = FactoryGirl.create :variant_property
      get :index
      assigns(:variant_properties).should eq([variant_property])
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end 
  end

  describe "GET #show" do
    it_behaves_like 'assign and render', :show, :variant_property
  end

  describe "GET #new" do
    it "assigns a new property to @variant_property" do
      get :new
      assigns(:variant_property).should be_an_instance_of PZS::VariantProperty 
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render', :edit, :variant_property
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new variant_property in the database" do
        expect{
          post :create, variant_property: FactoryGirl.attributes_for(:variant_property)
        }.to change(PZS::VariantProperty,:count).by(1)
      end
      it "redirects to the :show template" do
        post :create, variant_property: FactoryGirl.attributes_for(:variant_property)
        response.should redirect_to admin_variant_property_url(PZS::VariantProperty.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new variant_property in the database" do
        expect{
          post :create, variant_property: FactoryGirl.attributes_for(:variant_property, :display_name => nil)
        }.to_not change(PZS::VariantProperty,:count)
      end
      it "re-renders the :new template" do
        post :create, variant_property: FactoryGirl.attributes_for(:variant_property, :display_name => nil)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_variant_property) {FactoryGirl.create(:variant_property)}

    context "valid attributes" do
      let(:new_variant_property) {FactoryGirl.attributes_for(:size_variant_property)}
      it "locates the requested variant_property" do
        put :update, id: existing_variant_property, variant_property: new_variant_property
        assigns(:variant_property).should eq(existing_variant_property)      
      end

      it "changes variant_property's attributes" do
        put :update, id: existing_variant_property, variant_property: new_variant_property
        existing_variant_property.reload # to check that our updates are actually persisted
        existing_variant_property.display_name.should eq(new_variant_property[:display_name])
      end

      it "redirects to the updated variant_property" do
        put :update, id: existing_variant_property, variant_property: FactoryGirl.attributes_for(:variant_property)
        response.should redirect_to admin_variant_property_url(existing_variant_property)
      end
    end

    context "invalid attributes" do
      it "locates the requested variant_property" do
        put :update, id: existing_variant_property, variant_property: FactoryGirl.attributes_for(:invalid_variant_property)
        assigns(:variant_property).should eq(existing_variant_property)      
      end

      it "does not change variant_property's attributes" do
        put :update, id: existing_variant_property, variant_property: FactoryGirl.attributes_for(:invalid_variant_property)
        existing_variant_property.reload # to check that our updates are actually persisted
        existing_variant_property.display_name.should_not be_nil
      end

      it "re-renders the edit method" do
        put :update, id: existing_variant_property, variant_property: FactoryGirl.attributes_for(:invalid_variant_property)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:existing_variant_property) {FactoryGirl.create(:variant_property)}

    it "deletes the variant_property" do
      expect{
        delete :destroy, id: existing_variant_property
      }.to change(PZS::VariantProperty,:count).by(-1)
    end

    it "marks it as deleted" do
      existing_variant_property.reload
      expect{
        delete :destroy, id: existing_variant_property
      }.to change(PZS::VariantProperty.with_deleted,:count).by(0)
    end

    it "redirects to property#index" do
      delete :destroy, id: existing_variant_property
      response.should redirect_to admin_variant_properties_path
    end
  end
end