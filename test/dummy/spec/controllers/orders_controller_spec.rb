require 'spec_helper'

describe PZS::OrdersController, :type => :controller do
  render_views

  let(:current_user) { FactoryGirl.create(:specific_user) }
  before(:each) do
    sign_in current_user
  end

  describe "POST #create" do
    it "assigns cart to @cart" do
      cart_id = current_user.cart.id
      post :create, :order => build_attributes(:order_with_addresses)
      assigns(:cart).id.should eq cart_id
    end
    it "assigns all shipment_conditions to @shipment_conditions" do
      v = FactoryGirl.create :shipment_condition
      post :create, :order => build_attributes(:order_with_addresses)
      assigns(:shipment_conditions).should eq(PlazrStore::ShipmentCondition.all)
    end
    xit "calls @order.load_user" do
      o = FactoryGirl.build(:order)
      post :create, :order => build_attributes(:order_with_addresses)
      o.should_receive(:load_user).with(current_user)
    end
    it "sets order's user and email" do
      post :create, :order => build_attributes(:order_with_addresses)
      assigns(:order).email.should eq current_user.email
    end
    xit "calls @order.add_cart_and_update_status" do
      o = FactoryGirl.build(:order)
      post :create, :order => build_attributes(:order_with_addresses)
      o.should_receive(:add_cart_and_update_status).with(assigns(:cart))
    end
    it "sets order's cart" do
      cart_id = current_user.cart.id
      post :create, :order => build_attributes(:order_with_addresses)
      assigns(:order).cart_id.should eq cart_id
    end
    context "with valid attributes for order and cart" do
      it "saves the new order in the database" do
        expect{
          post :create, :order => build_attributes(:order_with_addresses)
        }.to change(PZS::Order, :count).by(1)
      end
      it "marks the cart as deleted" do
        post :create, :order => build_attributes(:order_with_addresses)
        lambda{ PZS::Cart.find(assigns(:order).cart.id)  }.should raise_error(ActiveRecord::RecordNotFound)
      end
      it "sets session variable :last_order" do
        post :create, :order => build_attributes(:order_with_addresses)
        session[:last_order].should eq assigns(:order).id
      end
      it "redirects to the order's receipt" do
        post :create, :order => build_attributes(:order_with_addresses)
        response.should redirect_to receipt_url
      end
    end

    context "with invalid attributes" do
      it "does not save the new order in the database" do
        expect{
          post :create, :order => build_attributes(:order)
        }.to_not change(PZS::Order, :count)
      end
      it "re-renders the :new template" do
        post :create, :order => build_attributes(:order)
        response.should render_template :new
      end
    end
  end

  describe "GET #history" do
    it "renders the :history template when the user is logged in" do
      get :history
      response.should render_template :history
    end
    it "redirects to root when the user is not logged in" do
      sign_out current_user
      get :history
      response.should redirect_to :plazr_auth
    end
  end

  describe "GET #new" do
    it "assigns cart to @cart" do
      # FactoryGirl.create :cart
      get :new
      assigns(:cart).id.should eq current_user.cart.id
    end
    it "assigns all shipment_conditions to @shipment_conditions" do
      v = FactoryGirl.create :shipment_condition
      get :new
      assigns(:shipment_conditions).should eq([v])
    end
    xit "calls @order.load_user" do
      o = FactoryGirl.build(:order)
      get :new
      o.should_receive(:load_user).with(current_user)
    end
    it "sets order's user and email" do
      get :new
      assigns(:order).user_id.should eq current_user.id
      assigns(:order).email.should eq current_user.email
    end
    it_behaves_like 'default admin new method', :order, PZS::Order
  end

  describe "GET #receipt" do
    context "with session[:last_order] set" do
      it "assigns the requested order to @order" do
        # m = FactoryGirl.create order_with_addresses
        post :create, :order => build_attributes(:order_with_addresses)
        get :receipt
        assigns(:order).should eq(PZS::Order.find(session[:last_order]))
      end
      it "renders the :receipt template" do
        post :create, :order => build_attributes(:order_with_addresses)
        get :receipt
        response.should render_template :receipt
      end
    end
    context "with session[:last_order] not set" do
      it "redirects to root" do
        get :receipt
        response.should redirect_to :plazr_auth
      end
    end
  end
end

