require 'spec_helper'

describe PZS::Admin::BrandsController, :type => :controller do
  # render_views

  describe "GET #index" do
    it_behaves_like 'assign and render for index', :brand
  end

  describe "GET #show" do
    it_behaves_like 'assign and render for show and edit', :show, :brand
  end

  describe "GET #new" do
    it_behaves_like 'assign and render for new', :brand, PZS::Brand
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render for show and edit', :edit, :brand
  end

  describe "POST #create" do
    it_behaves_like 'admin create', :brand, PZS::Brand
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
    it_behaves_like 'admin destroy', :brand, PZS::Brand
  end
end
