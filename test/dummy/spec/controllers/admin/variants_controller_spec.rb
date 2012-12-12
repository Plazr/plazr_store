require 'spec_helper'
require 'spec_support'

describe PZS::Admin::VariantsController, :type => :controller do
  render_views

  describe "GET #index" do
    it "assigns the requested product to @product" do
      p = FactoryGirl.create :product
      get :index, :product_id => p
      assigns(:product).should eq(p)
    end

    it "assigns variants" do
      m = FactoryGirl.create :variant
      p = m.product
      get :index, :product_id => p
      assigns(:variants).should eq([m])
    end

    it "renders the :index template" do
      p = FactoryGirl.create :product
      get :index, :product_id => p
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested product to @product" do
      m = FactoryGirl.create :variant
      p = m.product
      get :show, :id => m, :product_id => p
      assigns(:product).should eq(p)
    end

    it "assigns the requested variant to @variant" do
      m = FactoryGirl.create :variant
      p = m.product
      get :show, :id => m, :product_id => p
      assigns(:variant).should eq(m)
    end

    it "renders the :show template" do
      m = FactoryGirl.create :variant
      p = m.product
      get :show, id: m, product_id: p
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns the requested product to @product" do
      p = FactoryGirl.create :product
      get :new, :product_id => p
      assigns(:product).should eq(p)
    end

    it "assigns a new variant to @variant" do
      p = FactoryGirl.create :product
      get :new, :product_id => p
      assigns(:variant).should be_an_instance_of PZS::Variant
    end
    it "assigns @variant with attribute 'visible' set to true" do
      p = FactoryGirl.create :product
      get :new, :product_id => p, :variant => FactoryGirl.attributes_for(:variant, visible: true)
      assigns(:variant).visible.should be_true
    end
    it "renders the :new template" do
      p = FactoryGirl.create :product
      get :new, :product_id => p
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested product to @product" do
      m = FactoryGirl.create :variant
      p = m.product
      get :edit, :id => m, :product_id => p
      assigns(:product).should eq(p)
    end

    it "assigns the requested variant to @variant" do
      m = FactoryGirl.create :variant
      p = m.product
      get :edit, :id => m, :product_id => p
      assigns(:variant).should eq(m)
    end

    it "renders the :edit template" do
      m = FactoryGirl.create :variant
      p = m.product
      get :edit, id: m, product_id: p
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    it "assigns the requested product to @product" do
      v = build_attributes(:variant)
      post :create, product_id: v[:product_id], :variant => v
      assigns(:product).should eq(PZS::Product.find(v[:product_id])) # nao sei se devia ser assim o teste, mas passa :)
    end

    it "assigns @variant with form's attributes" do
      v = build_attributes(:variant)
      post :create, product_id: v[:product_id], :variant => v

      variant_assigned = trim_hash_attributes(assigns(:variant).attributes)
      variant_assigned.should eq(v)
    end

    context "with valid attributes" do
      it "saves the new variant in the database" do
        v=build_attributes(:variant)
        expect{
          post :create, product_id: v[:product_id], :variant => v
        }.to change(PZS::Variant, :count).by(1)
      end
      it "redirects to the :show template" do
        v=build_attributes(:variant)
        post :create, product_id: v[:product_id], :variant => v
        response.should redirect_to admin_product_variant_url(v[:product_id], PZS::Variant.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new variant in the database" do
        expect{
          v=build_attributes(:invalid_variant)
          post :create, product_id: v[:product_id], :variant => v
        }.to_not change(PZS::Variant, :count)
      end
      it "re-renders the :new template" do
        v=build_attributes(:invalid_variant)
        post :create, product_id: v[:product_id], :variant => v
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_instance) {FactoryGirl.create(:variant)}
    let(:product) {existing_instance.product}

    it "assigns the requested product to @product" do
      put :update, id: existing_instance, product_id: product
      assigns(:product).should eq(product)
    end

    context "valid attributes" do
      let(:new_instance) { build_attributes(:variant_v2)}

      it "locates the requested variant" do
        put :update, id: existing_instance, product_id: product, :variant => new_instance
        assigns(:variant).should eq(existing_instance)      
      end

      [:sku, :price, :visible, :is_master, :product_id].each do |var|
        it "changes variant's #{var}" do
          put :update, id: existing_instance, product_id: product, :variant => new_instance
          existing_instance.reload # to check that our updates are actually persisted
          existing_instance.send(var).should eq(new_instance[var])
        end
      end

      it "redirects to the updated variant" do
        put :update, id: existing_instance, product_id: product, :variant => new_instance
        response.should redirect_to admin_product_variant_url(product, existing_instance)
      end
    end

    context "invalid attributes" do
      it "locates the requested variant" do
        put :update, id: existing_instance, product_id: product, :variant => FactoryGirl.attributes_for(:invalid_variant)
        assigns(:variant).should eq(existing_instance)      
      end

      [:sku, :price, :visible, :is_master, :product_id].each do |var|
        it "does not change variant's #{var}" do
          old_var = existing_instance.send(var)
          put :update, id: existing_instance, product_id: product, :variant => FactoryGirl.attributes_for(:invalid_variant)
          existing_instance.reload # to check that our updates are actually persisted
          existing_instance.send(var).should eq(old_var)
        end
      end

      it "re-renders the edit method" do
        put :update, id: existing_instance, product_id: product, :variant => FactoryGirl.attributes_for(:invalid_variant)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:existing_instance) {FactoryGirl.create(:variant)}
    let(:product) {existing_instance.product}

    it "assigns the requested product to @product" do
      delete :destroy, id: existing_instance, product_id: product
      assigns(:product).should eq(product)
    end

    it "deletes the variant" do
      expect{
        delete :destroy, id: existing_instance, product_id: product
      }.to change(PZS::Variant, :count).by(-1)
    end

    it "marks it as deleted" do
      existing_instance.reload # to check that our updates are actually persisted
      expect{
        delete :destroy, id: existing_instance, product_id: product
      }.to change(PZS::Variant.with_deleted, :count).by(0)
    end

    it "redirects to variants#index" do
      delete :destroy, id: existing_instance, product_id: product
      response.should redirect_to admin_product_variants_path
    end
  end
end
