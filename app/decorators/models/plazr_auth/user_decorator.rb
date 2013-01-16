PlazrAuth::User.class_eval do
  # has_many :cart

  # Get all the shopping carts, with the deleted ones included, of a given user
  def carts
    PlazrStore::Cart.with_deleted.find_all_by_user_id(self.id)
  end

  # Get the shopping cart of a given user (or it creates one if it does not exists)
  def cart
    PlazrStore::Cart.find_or_create_by_user_id(self.id)
  end

  # Get the wishlist of a given user (or creates one if it does not exists)
  def wishlist
    PlazrStore::Wishlist.find_or_create_by_user_id(self.id)
  end

  # Get all orders, and associated information, for a given user
  def orders
    # has eager loading
    PlazrStore::Order.includes({:cart => {:cart_variants => {:variant => :variant_property_values}}}, :shipment_condition, :shipping_address, :billing_address).find_all_by_user_id(self.id)
  end

end
