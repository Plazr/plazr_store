module PlazrStore
  # Class representing a shopping cart for a registred user in a given store
  class Cart < ActiveRecord::Base
    include PZS::ParanoiaInterface

    ## Relations ##

    has_one :order

    has_many :cart_variants
    has_many :variants, :through => :cart_variants

    ## Attributes ##
    attr_accessible :item_amount, :total_price, :user_id

    ## Validations ##
    validates :user_id, presence: true


    ## Instance Methods ##
    
    # Add an item to the shopping cart
    def add(variant, amount = 1)
      cart_variant = self.cart_variants.find_or_initialize_by_variant_id(variant.id)
      cart_variant.add(amount)
    end

    # Remove a given item from the shopping cart
    def remove(variant)
      self.cart_variants.find_by_variant_id(variant.id).remove
    end

    # Returns the user associated with this shopping cart
    def user
      PlazrAuth::User.find(self.user_id)
    end

    # def user=(user)
    #   # Set this cart's owner
    #   self.user_id = PlazrAuth::User.find(user.id)
    # end

    # Updates the current amount and total price of the shopping cart
    def update_amount_and_price
      self.update_attributes(
        item_amount: self.cart_variants.map(&:amount).sum,
        total_price: self.cart_variants.map(&:price).sum
      )
    end

  end
end
