PlazrAuth::User.class_eval do
  # has_many :cart
  def carts
    PlazrStore::Cart.with_deleted.find_all_by_user_id(self.id)
  end

  def cart
    PlazrStore::Cart.find_or_create_by_user_id(self.id)
  end

  # has_many :orders
  def orders
    PlazrStore::Order.find_all_by_user_id(self.id)
  end

  def wishlist
    PZS::Wishlist.find_all_by_user_id(self.id)
  end
end
