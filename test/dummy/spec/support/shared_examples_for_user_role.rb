shared_examples_for 'user role' do |current_user|
  it "can access all wishlist actions" do
    should be_able_to(:access, :wishlist_actions)
  end
  it "can manage his own wishlist" do
    should be_able_to(:manage, PZS::Wishlist.new(user_id: current_user.id))
  end

  it "can access all cart actions" do
    should be_able_to(:access, :cart_actions)
  end
  it "can manage his own cart" do
    should be_able_to(:manage, PZS::Cart.new(user_id: current_user.id))
  end

  it "can access all order actions" do
    should be_able_to(:access, :orders_actions)
  end
  it "can create a new order" do
    should be_able_to(:create, PZS::Order.new(user_id: current_user.id))
  end
  it "can exhibit orders and show a specific order" do
    should be_able_to(:read, PZS::Order.new(user_id: current_user.id))
  end
  it "cannot show an order that doesn't belong to him" do
    should_not be_able_to(:read, PZS::Order.new)
  end

  it "cannot manage nor admin the store" do
    should_not be_able_to(:manage, :store)
  end
end

