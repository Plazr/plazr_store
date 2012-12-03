require 'spec_helper'

describe PZS::Admin::DiscountTypesController, :type => :controller do 
  #render_views

  describe "GET #index" do
    it_behaves_like 'assign and render for index', :discount_type
  end

  describe "GET #show" do
    it_behaves_like 'assign and render for show and edit', :show, :discount_type
  end

  describe "GET #new" do
    it_behaves_like 'assign and render for new', :discount_type, PZS::DiscountType
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render for show and edit', :edit, :discount_type
  end

  describe "POST #create" do
    it_behaves_like 'admin create', :discount_type, PZS::DiscountType
  end

  describe 'PUT #update' do
    let(:existing_discount_type) {FactoryGirl.create(:discount_type)}

    context "valid attributes" do
      let(:new_discount_type) { FactoryGirl.attributes_for(:black_friday_discount) }
      it "locates the requested discount type" do
        put :update, id: existing_discount_type, discount_type: new_discount_type
        assigns(:discount_type).should eq(existing_discount_type)      
      end

      it "changes discount type's attributes" do
        put :update, id: existing_discount_type, discount_type: new_discount_type
        existing_discount_type.reload # to check that our updates are actually persisted
        existing_discount_type.name.should eq(new_discount_type[:name])
      end

      it "redirects to the updated discount type" do
        put :update, id: existing_discount_type, discount_type: FactoryGirl.attributes_for(:discount_type)
        response.should redirect_to admin_discount_type_url(existing_discount_type)
      end
    end

    context "invalid attributes" do
      it "locates the requested discount type" do
        put :update, id: existing_discount_type, discount_type: FactoryGirl.attributes_for(:invalid_discount_type)
        assigns(:discount_type).should eq(existing_discount_type)      
      end

      it "does not change discount type's attributes" do
        put :update, id: existing_discount_type, discount_type: FactoryGirl.attributes_for(:invalid_discount_type)
        existing_discount_type.reload # to check that our updates are actually persisted
        existing_discount_type.name.should_not be_nil
      end

      it "re-renders the edit method" do
        put :update, id: existing_discount_type, discount_type: FactoryGirl.attributes_for(:invalid_discount_type)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'admin destroy', :discount_type, PZS::DiscountType
  end
end
