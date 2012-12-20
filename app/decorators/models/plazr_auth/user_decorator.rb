PlazrAuth::User.class_eval do
  def wishlist
    PZS::Wishlist.find_by_user_id(id)
  end
end
