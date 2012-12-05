module PlazrStore
  class DiscountType < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    ## Relations ##
    has_many :promotions
    has_many :coupons

    ## Attributes ##
    attr_accessible :description, :name

    validates :name, :presence => true
  end
end
