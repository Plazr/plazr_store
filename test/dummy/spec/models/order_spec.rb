require 'spec_helper'

describe PZS::Order, type: :model do
  describe ".create" do
    it "creates a new instance given valid attributes" do
      FactoryGirl.create(:order_full).should be_valid
    end
    xit "validates promotional_code and sets it to the order when validated" do
      # sets ...
      # part.valid?
      # assertion
    end
    describe "updates state" do
      let!(:order) { FactoryGirl.build(:order_full) }
      context "state is 'cancelled'" do
        it "does nothing" do
          order.state = "cancelled"
          order.save
          order.state.should eq "cancelled"
        end
      end
      context "to be cancelled is true" do
        it "sets state to 'cancelled'" do
          order.to_be_cancelled = true
          order.save
          order.state.should eq "cancelled"
        end
      end
      context "all order variants state is 'shipped'" do
        it "sets state to 'shipped'" do
          ActiveRecord::Base.transaction do
            order.cart.cart_variants.each do |c|
              c.update_attributes :state => "shipped"
            end
            order.save
          end
          order.state.should eq "shipped"
        end
      end
      context "all order variants state is 'processing'" do
        it "sets state to 'processing'" do
          ActiveRecord::Base.transaction do
            order.cart.cart_variants.each do |c|
              c.update_attributes :state => "processing"
            end
            order.save
          end
          order.state.should eq "processing"
        end
      end
    end
    describe "delivers order confirmation" do
      let(:order) { FactoryGirl.build(:order_full) }
      xit "sends an order notification to the order's owner" do
        # PZS::Notifier.order_notification(self).deliver
      end
    end
  end

  describe ".new" do
    let!(:order) { PZS::Order.new }
    describe ".load_defaults" do
      it "builds billing_address" do
        order.billing_address.should be_an_instance_of PZS::Address
      end
      it "builds shipping_address" do
        order.shipping_address.should be_an_instance_of PZS::Address
      end
      it "sets payment_state to 'processing'" do
        order.payment_state.should eq "processing"
      end
      it "sets shipment_state to 'processing'" do
        order.shipment_state.should eq "processing"
      end
      it "sets state to 'processing'" do
        order.state.should eq "processing"
      end
    end
  end

  describe "#Relations" do
    it "belongs to cart" do 
      FactoryGirl.create(:order_full).should belong_to :cart
    end

    it "belongs to promotional_code" do 
      FactoryGirl.create(:order_full).should belong_to :promotional_code
    end

    it "belongs to billing_address" do 
      FactoryGirl.create(:order_full).should belong_to :billing_address
    end

    it "belongs to shipping_address" do 
      FactoryGirl.create(:order_full).should belong_to :shipping_address
    end

    it "belongs to shipment_condition" do 
      FactoryGirl.create(:order_full).should belong_to :shipment_condition
    end

    xit "has one to payment" do 
      FactoryGirl.create(:order_full).should have_one :payment
    end
  end

  describe "#Validations" do
    [:email, :item_total, :adjustment_total, :total, :payment_state, :shipment_state, :state, :shipment_condition_id, :cart_id, :user_id].each do |att|
      it "requires #{att} to be set" do
        FactoryGirl.create(:order_full).should validate_presence_of att
      end
    end
  end

  describe "Instance Methods" do
    describe "#add_cart_and_update_status" do
      it "changes cart_variants state to 'processing'" do
        order = FactoryGirl.build :order_full
        cart = FactoryGirl.create :cart
        order.add_cart_and_update_status(cart)
        cart.cart_variants.all? { |cv| cv.state == "processing" }.should be_true
      end
      it "sets order's cart when cart is valid" do
        order = FactoryGirl.build :order_full
        cart = FactoryGirl.create :cart
        order.add_cart_and_update_status(cart)
        order.cart_id.should eq cart.id
      end
    end
    describe "#cart" do
      it "gets the cart even if it is marked as deleted" do
        order = FactoryGirl.create :order_full
        PZS::Cart.find(order.cart.id).delete
        order.cart.should eq PZS::Cart.with_deleted.find(order.cart.id)
      end
    end
    describe "#load_user" do
      context "user is logged in" do
        it "sets order's user_id" do
          order = FactoryGirl.build :order_without_user
          user = FactoryGirl.create :specific_user
          order.load_user(user)
          order.user_id.should eq user.id
        end
        it "sets order's email" do
          order = FactoryGirl.build :order_without_user
          user = FactoryGirl.create :specific_user
          order.load_user(user)
          order.email.should eq user.email
        end
      end
    end
    describe "#user" do
      it "gets order's owner" do
        order = FactoryGirl.create :order_full
        order.user.should eq PlazrAuth::User.find(order.user_id)
      end
    end
  end
end

