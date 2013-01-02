require 'spec_helper'

describe PZS::Admin::ProductCategoriesController, :type => :controller do 
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :product_category
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :product_category
  end

  describe "GET #new" do
    it "assigns all product_categories that aren't leaf to @product_categories" do
      m = FactoryGirl.create_list(:product_category, 5)
      get :new
      assigns(:product_categories).should eq(m)
    end
    it_behaves_like 'default admin new method', :product_category, PZS::ProductCategory
  end

  describe "GET #edit" do
    it "assigns all product_categories except the one to be edited to @product_categories" do
      m = FactoryGirl.create_list(:product_category, 5)
      n = FactoryGirl.create(:product_category_leaf)
      get :edit, id: n
      assigns(:product_categories).should eq(m << n.parent_product_category)
    end
    it_behaves_like 'default admin show and edit methods', :edit, :product_category
  end

  describe "POST #create" do
    context "with valid attributes" do
      describe "assigns is_leaf attribute" do
        it "false if parent category is empty" do
          post :create, :product_category => FactoryGirl.attributes_for(:product_category)
          assigns(:product_category).is_leaf.should be_false
        end
        it "true if parent category is not empty" do
          parent = FactoryGirl.create(:product_category)
          post :create, :product_category => FactoryGirl.attributes_for(:product_category_v2, :parent_product_category_id => parent.id)
          assigns(:product_category).is_leaf.should be_true
        end
      end
      it "saves the new product_category in the database" do
        expect{
          post :create, :product_category => FactoryGirl.attributes_for(:product_category)
        }.to change(PZS::ProductCategory, :count).by(1)
      end
      it "redirects to the :show template" do
        post :create, :product_category => FactoryGirl.attributes_for(:product_category)
        response.should redirect_to send("admin_product_category_url".to_sym, PZS::ProductCategory.send(:last))
      end
    end

    context "with invalid attributes" do
      it "does not save the new product_category in the database" do
        expect{
          post :create, :product_category => FactoryGirl.attributes_for("invalid_product_category".to_sym)
        }.to_not change(PZS::ProductCategory, :count)
      end

      it "assigns all product_categories except the one to be edited to @product_categories" do
        m = FactoryGirl.create_list(:product_category, 5)
        n = FactoryGirl.create :product_category
        get :edit, id: n
        assigns(:product_categories).should eq(m)
      end

      it "re-renders the :new template" do
        post :create, :product_category => FactoryGirl.attributes_for("invalid_product_category".to_sym)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_instance) {FactoryGirl.create(:product_category)}

    context "valid attributes" do
      let(:new_instance) { FactoryGirl.attributes_for("product_category_v2".to_sym)}

      it "locates the requested product_category" do
        put :update, id: existing_instance, :product_category => new_instance
        assigns(:product_category).should eq(existing_instance)      
      end

      it "checks the parent_product_category_id" do
        post :create, :product_category => FactoryGirl.attributes_for(:product_category)
        assigns(:is_leaf).should be_false
      end

      it "changes product_category's attributes" do
        put :update, id: existing_instance, :product_category => new_instance
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(:name).should eq(new_instance[:name])
      end

      context "checking the is_leaf attribute" do
        it "should be false" do
          put :update, id: existing_instance, :product_category => new_instance
          assigns(:product_category).is_leaf.should be_false
        end
        it "should be true" do
          parent = FactoryGirl.create(:product_category)
          put :update, id: existing_instance, :product_category => FactoryGirl.attributes_for(:product_category_v2, :parent_product_category_id => parent.id)
          assigns(:product_category).is_leaf.should be_true
        end
      end
      
      it "redirects to the updated product_category" do
        put :update, id: existing_instance, :product_category => new_instance
        response.should redirect_to send("admin_product_category_url".to_sym, existing_instance)
      end
    end

    context "invalid attributes" do
      it "locates the requested product_category" do
        put :update, id: existing_instance, :product_category => FactoryGirl.attributes_for("invalid_product_category".to_sym)
        assigns(:product_category).should eq(existing_instance)      
      end

      it "does not change product_category's attributes" do
        put :update, id: existing_instance, :product_category => FactoryGirl.attributes_for("invalid_product_category".to_sym)
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(:name).should_not be_nil
      end
      
      it "assigns all product_categories except the one being edited to @product_categories" do
        m = FactoryGirl.create_list(:product_category, 5)
        n = FactoryGirl.create :product_category
        get :edit, id: n
        PZS::ProductCategory.stub(:where).and_return(m)
        assigns(:product_categories).should eq(m)
      end

      it "re-renders the edit method" do
        put :update, id: existing_instance, :product_category => FactoryGirl.attributes_for("invalid_product_category".to_sym)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :product_category, PZS::ProductCategory
  end
end
