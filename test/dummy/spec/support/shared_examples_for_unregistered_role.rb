shared_examples_for 'unregistered role' do 
  it "can exhibit products and show a specific product" do
    should be_able_to(:read, PZS::Product.new)
  end
  it "can exhibit pages and show a specific page" do
    should be_able_to(:read, PZS::Page.new)
  end

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

