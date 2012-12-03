require 'spec_helper'

describe PZS::Admin::VariantPropertiesController, :type => :controller do 
  #render_views

  describe "GET #index" do
    it_behaves_like 'assign and render for index', :variant_property
  end

  describe "GET #show" do
    it_behaves_like 'assign and render for show and edit', :show, :variant_property
  end

  describe "GET #new" do
    it_behaves_like 'assign and render for new', :variant_property, PZS::VariantProperty
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render for show and edit', :edit, :variant_property
  end

  describe "POST #create" do
    it_behaves_like 'admin create', :variant_property, PZS::VariantProperty
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
    it_behaves_like 'admin destroy', :variant_property, PZS::VariantProperty
  end
end
