require 'spec_helper'

describe PZS::Admin::VariantCategoriesController, :type => :controller do 
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :variant_category
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :variant_category
  end

  describe "GET #new" do
    it "assigns all variant_categories that aren't leaf to @variant_categories" do
      m = FactoryGirl.create_list(:variant_category_not_leaf, 5)
      get :new
      assigns(:variant_categories).should eq(m)
    end
    it_behaves_like 'default admin new method', :variant_category, PZS::VariantCategory
  end

  describe "GET #edit" do
    it "assigns all variant_categories except the one to be edited to @variant_categories" do
      m = FactoryGirl.create_list(:variant_category_not_leaf, 5)
      n = FactoryGirl.create :variant_category
      get :edit, id: n
      assigns(:variant_categories).should eq(m)
    end
    it_behaves_like 'default admin show and edit methods', :edit, :variant_category
  end

  describe "POST #create" do
    context "with valid attributes" do
      describe "assigns is_leaf attribute" do
        it "false if parent category is empty" do
          post :create, :variant_category => FactoryGirl.attributes_for(:variant_category)
          assigns(:variant_category).is_leaf.should be_false
        end
        it "true if parent category is not empty" do
          parent = FactoryGirl.create(:variant_category)
          post :create, :variant_category => FactoryGirl.attributes_for(:variant_category_v2, :parent_variant_category_id => parent.id)
          assigns(:variant_category).is_leaf.should be_true
        end
      end
      it "saves the new variant_category in the database" do
        expect{
          post :create, :variant_category => FactoryGirl.attributes_for(:variant_category)
        }.to change(PZS::VariantCategory, :count).by(1)
      end
      it "redirects to the :show template" do
        post :create, :variant_category => FactoryGirl.attributes_for(:variant_category)
        response.should redirect_to send("admin_variant_category_url".to_sym, PZS::VariantCategory.send(:last))
      end
    end

    context "with invalid attributes" do
      it "does not save the new variant_category in the database" do
        expect{
          post :create, :variant_category => FactoryGirl.attributes_for("invalid_variant_category".to_sym)
        }.to_not change(PZS::VariantCategory, :count)
      end

      it "assigns all variant_categories except the one to be edited to @variant_categories" do
        m = FactoryGirl.create_list(:variant_category, 5)
        n = FactoryGirl.create :variant_category
        get :edit, id: n
        assigns(:variant_categories).should eq(m)
      end

      it "re-renders the :new template" do
        post :create, :variant_category => FactoryGirl.attributes_for("invalid_variant_category".to_sym)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_instance) {FactoryGirl.create(:variant_category)}

    context "valid attributes" do
      let(:new_instance) { FactoryGirl.attributes_for("variant_category_v2".to_sym)}

      it "locates the requested variant_category" do
        put :update, id: existing_instance, :variant_category => new_instance
        assigns(:variant_category).should eq(existing_instance)      
      end

      it "checks the parent_variant_category_id" do
        post :create, :variant_category => FactoryGirl.attributes_for(:variant_category)
        assigns(:is_leaf).should be_false
      end

      it "changes variant_category's attributes" do
        put :update, id: existing_instance, :variant_category => new_instance
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(:name).should eq(new_instance[:name])
      end

      context "checking the is_leaf attribute" do
        it "should be false" do
          put :update, id: existing_instance, :variant_category => new_instance
          assigns(:variant_category).is_leaf.should be_false
        end
        it "should be true" do
          parent = FactoryGirl.create(:variant_category)
          put :update, id: existing_instance, :variant_category => FactoryGirl.attributes_for(:variant_category_v2, :parent_variant_category_id => parent.id)
          assigns(:variant_category).is_leaf.should be_true
        end
      end
      
      it "redirects to the updated variant_category" do
        put :update, id: existing_instance, :variant_category => new_instance
        response.should redirect_to send("admin_variant_category_url".to_sym, existing_instance)
      end
    end

    context "invalid attributes" do
      it "locates the requested variant_category" do
        put :update, id: existing_instance, :variant_category => FactoryGirl.attributes_for("invalid_variant_category".to_sym)
        assigns(:variant_category).should eq(existing_instance)      
      end

      it "does not change variant_category's attributes" do
        put :update, id: existing_instance, :variant_category => FactoryGirl.attributes_for("invalid_variant_category".to_sym)
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(:name).should_not be_nil
      end
      
      it "assigns all variant_categories except the one being edited to @variant_categories" do
        m = FactoryGirl.create_list(:variant_category, 5)
        n = FactoryGirl.create :variant_category
        get :edit, id: n
        PZS::VariantCategory.stub(:where).and_return(m)
        assigns(:variant_categories).should eq(m)
      end

      it "re-renders the edit method" do
        put :update, id: existing_instance, :variant_category => FactoryGirl.attributes_for("invalid_variant_category".to_sym)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :variant_category, PZS::VariantCategory
  end
end
