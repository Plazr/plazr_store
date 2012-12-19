PlazrAuth::User.class_eval do

  # has_many :cart
  def carts
    PlazrStore::Cart.with_deleted.find_all_by_user_id(self.id)
  end

  def cart
    PlazrStore::Cart.find_or_create_by_user_id(self.id)
  end

end
