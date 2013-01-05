require 'spec_helper'
require "cancan/matchers"

describe Ability do
  describe PlazrAuth::User do
    describe "Abilities" do
      context "when user isn't logged in (role: 'unregistered')", focus: true do
        current_user = nil
        subject(:ability){ Ability.new(current_user) }

        it_behaves_like 'unregistered role'
        it "cannot access wishlist actions" do
          should_not be_able_to(:access, :wishlist_actions)
        end
        it "cannot access cart actions" do
          should_not be_able_to(:access, :cart_actions)
        end
        it "cannot access order actions" do
          should_not be_able_to(:access, :orders_actions)
        end

        it "cannot manage nor admin the store" do
          should_not be_able_to(:manage, :store)
        end
      end
      context "when user is logged in" do
        context "when user is client (role: 'user')", focus: true do
          current_user = FactoryGirl.create :user_with_user_role
          subject(:ability){ Ability.new(current_user) }

          it_behaves_like 'unregistered role'
          it_behaves_like 'user role', current_user
          it "cannot show an order that doesn't belong to him" do
            should_not be_able_to(:read, PZS::Order.new)
          end

          it "cannot manage nor admin the store" do
            should_not be_able_to(:manage, :store)
          end
        end

        context "when user is staff (role: 'staff')" do
          current_user = FactoryGirl.create :staff
          subject(:ability){ Ability.new(current_user) }

          it_behaves_like 'unregistered role'
          it_behaves_like 'user role', current_user
          it_behaves_like 'staff role'
          it "cannot admin the store", focus: true do
            should_not be_able_to(:admin, :store)
          end
        end

        context "when user is admin (role: 'admin')" do
          current_user = FactoryGirl.create :admin
          subject(:ability){ Ability.new(current_user) }

          it_behaves_like 'unregistered role'
          it_behaves_like 'user role', current_user
          it_behaves_like 'staff role'
          it_behaves_like 'admin role'
        end

        context "when user is root (role: 'root')" do
          current_user = FactoryGirl.create :root
          subject(:ability){ Ability.new(current_user) }

          it_behaves_like 'unregistered role'
          it_behaves_like 'user role', current_user
          it_behaves_like 'staff role'
          it_behaves_like 'admin role'
        end
      end
    end
  end
end
