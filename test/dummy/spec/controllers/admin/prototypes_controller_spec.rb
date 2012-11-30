require 'spec_helper'

describe PZS::Admin::PrototypesController, :type => :controller do
  # render_views

  describe "GET #index" do
    it "assigns prototypes" do
      prototype = FactoryGirl.create :prototype
      get :index
      assigns(:prototypes).should eq([prototype])
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it_behaves_like 'assign and render', :show, :prototype
  end

  describe "GET #new" do
    describe "is filtered by #instance_variable_loading" do
      it_behaves_like 'before filter and assign', :new, :prototype, [:property]
    end
    it "assigns a new prototype to @prototype" do
      controller.stub(:instance_variable_loading)
      get :new
      assigns(:prototype).should be_an_instance_of PZS::Prototype 
    end
    it "renders the :new template" do
      controller.stub(:instance_variable_loading)
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    describe "is filtered by #instance_variable_loading" do
      it_behaves_like 'before filter and assign', :edit, :prototype, [:property]
    end
    it "assigns the requested prototype to @prototype" do
      controller.stub(:instance_variable_loading)
      p = FactoryGirl.create :prototype
      get :edit, id: p
      assigns(:prototype).should eq(p)
    end
    it "renders the :edit template" do
      controller.stub(:instance_variable_loading)
      get :edit, id: FactoryGirl.create(:prototype)
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new prototype in the database" do
        expect{
          post :create, prototype: FactoryGirl.attributes_for(:prototype)
        }.to change(PZS::Prototype,:count).by(1)
      end
      it "redirects to the :show template" do
        post :create, prototype: FactoryGirl.attributes_for(:prototype)
        response.should redirect_to admin_prototype_url(PZS::Prototype.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new prototype in the database" do
        expect{
          post :create, prototype: FactoryGirl.attributes_for(:invalid_prototype)
        }.to_not change(PZS::Prototype,:count)
      end
      it "re-renders the :new template" do
        post :create, prototype: FactoryGirl.attributes_for(:invalid_prototype)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:existing_prototype) {FactoryGirl.create(:clothes_prototype)}

    context "valid attributes" do
      it "locates the requested prototype" do
        put :update, id: existing_prototype, prototype: FactoryGirl.attributes_for(:prototype, name: "Jeans")
        assigns(:prototype).should eq(existing_prototype)      
      end

      it "changes prototype's attributes" do
        put :update, id: existing_prototype, prototype: FactoryGirl.attributes_for(:prototype, name: "Jeans")
        existing_prototype.reload # to check that our updates are actually persisted
        existing_prototype.name.should eq("Jeans")
      end

      it "redirects to the updated prototype" do
        put :update, id: existing_prototype, prototype: FactoryGirl.attributes_for(:clothes_prototype)
        response.should redirect_to admin_prototype_url(existing_prototype)
      end
    end

    context "invalid attributes" do
      it "locates the requested prototype" do
        put :update, id: existing_prototype, prototype: FactoryGirl.attributes_for(:invalid_prototype)
        assigns(:prototype).should eq(existing_prototype)      
      end

      it "does not change prototype's attributes" do
        put :update, id: existing_prototype, prototype: FactoryGirl.attributes_for(:invalid_prototype)
        existing_prototype.reload # to check that our updates are actually persisted
        existing_prototype.name.should_not be_nil
      end

      it "re-renders the edit method" do
        put :update, id: existing_prototype, prototype: FactoryGirl.attributes_for(:invalid_prototype)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:existing_prototype) {FactoryGirl.create(:prototype)}

    it "deletes the prototype" do
      expect{
        delete :destroy, id: existing_prototype
      }.to change(PZS::Prototype,:count).by(-1)
    end

    it "marks it as deleted" do
      existing_prototype.reload
      expect{
        delete :destroy, id: existing_prototype
      }.to change(PZS::Prototype.with_deleted, :count).by(0)
    end

    it "redirects to prototypes#index" do
      delete :destroy, id: existing_prototype
      response.should redirect_to admin_prototypes_path
    end
  end
end
