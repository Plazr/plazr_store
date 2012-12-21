module PlazrStore
  class Wishlist < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    
    ## Relations ##
    #has_and_belongs_to_many :variants
    has_many :variant_wishlists
    has_many :variants, :through => :variant_wishlists

    ## Attributes ##
    attr_accessible :is_private, :name, :user_id

    ## Instance Methods ##
    # belongs_to :user
    def user
      PlazrAuth::User.find(user_id)
    end

    def self.current_wishlist
      # where('user_id = ?', current_user.id)
    end
  end
end
