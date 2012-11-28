require 'spec_helper'

describe PZS::Admin::PropertiesController, :type => :controller do 
  #render_views

  describe "GET #index" do
    it "assigns property" do
      property = FactoryGirl.create :property
      get :index
      assigns(:properties).should eq([property])
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end 
  end

  describe "GET #show" do
    it_behaves_like 'assign and render', :show, :property
  end

  describe "GET #new" do
    it "assigns a new property to @property" do
      get :new
      assigns(:property).should be_an_instance_of PZS::Property 
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render', :edit, :property
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new property in the database" do
        expect{
          post :create, property: FactoryGirl.attributes_for(:property)
        }.to change(PZS::Property,:count).by(1)
      end
      it "redirects to the :show template" do
        post :create, property: FactoryGirl.attributes_for(:property)
        response.should redirect_to admin_property_url(PZS::Property.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new property in the database" do
        expect{
          post :create, property: FactoryGirl.attributes_for(:property, :display_name => nil)
        }.to_not change(PZS::Property,:count)
      end
      it "re-renders the :new template" do
        post :create, property: FactoryGirl.attributes_for(:property, :display_name => nil)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_property) {FactoryGirl.create(:property)}

    context "valid attributes" do
      let(:new_property) {FactoryGirl.attributes_for(:silk_property)}
      it "locates the requested property" do
        put :update, id: existing_property, property: new_property
        assigns(:property).should eq(existing_property)      
      end

      it "changes property's attributes" do
        put :update, id: existing_property, property: new_property
        existing_property.reload # to check that our updates are actually persisted
        existing_property.display_name.should eq(new_property[:display_name])
      end

      it "redirects to the updated property" do
        put :update, id: existing_property, property: FactoryGirl.attributes_for(:property)
        response.should redirect_to admin_property_url(existing_property)
      end
    end

    context "invalid attributes" do
      it "locates the requested property" do
        put :update, id: existing_property, property: FactoryGirl.attributes_for(:invalid_property)
        assigns(:property).should eq(existing_property)      
      end

      it "does not change property's attributes" do
        put :update, id: existing_property, property: FactoryGirl.attributes_for(:invalid_property)
        existing_property.reload # to check that our updates are actually persisted
        existing_property.display_name.should_not be_nil
      end

      it "re-renders the edit method" do
        put :update, id: existing_property, property: FactoryGirl.attributes_for(:invalid_property)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:existing_property) {FactoryGirl.create(:property)}

    it "deletes the property" do
      expect{
        delete :destroy, id: existing_property
      }.to change(PZS::Property,:count).by(-1)
    end

    it "marks it as deleted" do
      existing_property.reload
      expect{
        delete :destroy, id: existing_property
      }.to change(PZS::Property.with_deleted,:count).by(0)
    end

    it "redirects to property#index" do
      delete :destroy, id: existing_property
      response.should redirect_to admin_properties_path
    end
  end
end