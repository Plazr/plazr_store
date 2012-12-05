require 'spec_helper'

describe PZS::Admin::VariantsController, :type => :controller, focus: true do
  # render_views

  # describe "GET #index" do
  #   it_behaves_like 'default admin index method', :variant
  # end

  # describe "GET #show" do
  #   it_behaves_like 'default admin show and edit methods', :show, :variant
  # end

  # describe "GET #new" do
  #   # describe "is filtered by #instance_variable_loading" do
  #   #   it_behaves_like 'before filter and assign', :new, :variant, [:property, :variant_property]
  #   # end
  #   it "assigns a new variant to @variant" do
  #     # controller.stub(:instance_variable_loading)
  #     get :new
  #     assigns(:variant).should be_an_instance_of PZS::Variant 
  #   end
  #   it "renders the :new template" do
  #     # controller.stub(:instance_variable_loading)
  #     get :new
  #     response.should render_template :new
  #   end
  # end

  # describe "GET #edit" do
  #   # describe "is filtered by #instance_variable_loading" do
  #   #   it_behaves_like 'before filter and assign', :edit, :variant, [:property, :variant_property]
  #   # end
  #   it "assigns the requested variant to @variant" do
  #     # controller.stub(:instance_variable_loading)
  #     p = FactoryGirl.create :variant
  #     get :edit, id: p
  #     assigns(:variant).should eq(p)
  #   end
  #   it "renders the :edit template" do
  #     # controller.stub(:instance_variable_loading)
  #     get :edit, id: FactoryGirl.create(:variant)
  #     response.should render_template :edit
  #   end
  # end

  # describe "POST #create" do
  #   pending
  #   # context "with valid attributes" do
  #   #   it "saves the new variant in the database" do
  #   #     expect{
  #   #       post :create, variant => FactoryGirl.attributes_for(model)
  #   #     }.to change(PZS::Variant, :count).by(1)
  #   #   end
  #   #   it "redirects to the :show template" do
  #   #     post :create, model => FactoryGirl.attributes_for(model)
  #   #     response.should redirect_to send("admin_#{model}_url".to_sym, model_signature.send(:last))
  #   #   end
  #   # end

  #   # context "with invalid attributes" do
  #   #   it "does not save the new #{model} in the database" do
  #   #     expect{
  #   #       post :create, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
  #   #     }.to_not change(model_signature, :count)
  #   #   end
  #   #   it "re-renders the :new template" do
  #   #     post :create, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
  #   #     response.should render_template :new
  #   #   end
  #   # end
  #   # it_behaves_like 'default admin create method', :variant, PZS::Variant
  # end

  # describe 'PUT #update' do
  #   it_behaves_like 'default admin update method', :variant, :description
  # end

  # describe 'DELETE #destroy' do
  #   it_behaves_like 'default admin destroy method', :variant, PZS::Variant
  # end
end
