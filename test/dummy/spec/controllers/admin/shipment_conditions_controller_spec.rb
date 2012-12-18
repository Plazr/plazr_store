require 'spec_helper'

describe PZS::Admin::ShipmentConditionsController, :type => :controller do
  render_views

  describe "GET #index" do
    it_behaves_like 'default admin index method', :shipment_condition
  end

  describe "GET #show" do
    it_behaves_like 'default admin show and edit methods', :show, :shipment_condition
  end

  describe "GET #new" do
    it_behaves_like 'default admin new method', :shipment_condition, PZS::ShipmentCondition
  end

  describe "GET #edit" do
    it_behaves_like 'default admin show and edit methods', :edit, :shipment_condition
  end

  describe "POST #create" do
    it_behaves_like 'default admin create method', :shipment_condition, PZS::ShipmentCondition
  end

  describe 'PUT #update' do
    it_behaves_like 'default admin update method', :shipment_condition, [:service_name, :price]
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'default admin destroy method', :shipment_condition, PZS::ShipmentCondition
  end
end
