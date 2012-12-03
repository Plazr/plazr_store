require 'spec_helper'

describe PZS::Admin::PropertiesController, :type => :controller do 
  #render_views

  describe "GET #index" do
    it_behaves_like 'assign and render for index', :property
  end

  describe "GET #show" do
    it_behaves_like 'assign and render for show and edit', :show, :property
  end

  describe "GET #new" do
    it_behaves_like 'assign and render for new', :property, PZS::Property
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render for show and edit', :edit, :property
  end

  describe "POST #create" do
    it_behaves_like 'admin create', :property, PZS::Property
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
    it_behaves_like 'admin destroy', :property, PZS::Property
  end
end
