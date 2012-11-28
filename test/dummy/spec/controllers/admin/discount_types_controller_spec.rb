require 'spec_helper'

describe PZS::Admin::DiscountTypesController, :type => :controller do 
  #render_views

  describe "GET #index" do
    it "assigns discount type" do
      discount_type = FactoryGirl.create :discount_type
      get :index
      assigns(:discount_types).should eq([discount_type])
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end 
  end

  describe "GET #show" do
    it_behaves_like 'assign and render', :show, :discount_type
  end

  describe "GET #new" do
    it "assigns a new discount type to @discount_type" do
      get :new
      assigns(:discount_type).should be_an_instance_of PZS::DiscountType 
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it_behaves_like 'assign and render', :edit, :discount_type
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new discount type in the database" do
        expect{
          post :create, discount_type: FactoryGirl.attributes_for(:discount_type)
        }.to change(PZS::DiscountType,:count).by(1)
      end
      it "redirects to the :show template" do
        post :create, discount_type: FactoryGirl.attributes_for(:discount_type)
        response.should redirect_to admin_discount_type_url(PZS::DiscountType.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new discount type in the database" do
        expect{
          post :create, discount_type: FactoryGirl.attributes_for(:discount_type, :name => nil)
        }.to_not change(PZS::DiscountType,:count)
      end
      it "re-renders the :new template" do
        post :create, discount_type: FactoryGirl.attributes_for(:discount_type, :name => nil)
        response.should render_template :new
      end
    end
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
    let!(:existing_discount_type) {FactoryGirl.create(:discount_type)}

    it "deletes the discount type" do
      expect{
        delete :destroy, id: existing_discount_type
      }.to change(PZS::DiscountType,:count).by(-1)
    end

    it "marks it as deleted" do
      existing_discount_type.reload
      expect{
        delete :destroy, id: existing_discount_type
      }.to change(PZS::DiscountType.with_deleted,:count).by(0)
    end

    it "redirects to discount_type#index" do
      delete :destroy, id: existing_discount_type
      response.should redirect_to admin_discount_types_path
    end
  end
end
