module PlazrStore
  class Wishlist < ActiveRecord::Base
    ## Relations ##
    has_many :variant_wishlists
    has_many :variants, :through => :variant_wishlistsz

    ## Attributes ##
    attr_accessible :is_private, :name

    ## Instance Methods ##
    # belongs_to :user
    def user
      PlazrAuth::User.find(user_id)
    end
  end
end
