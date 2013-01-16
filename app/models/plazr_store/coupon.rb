module PlazrStore
  # Class representing a coupon with a promotional code and a single user associated
  # It is designed for a one time use
  class Coupon < ActiveRecord::Base
    ## Relations ##
    belongs_to :promotional_code
    # belongs_to :user TODO metodo que chama api
    
    ## Attributes ##
    attr_accessible :promotional_code_id, :user_id

    ## Validations ##
    validates :promotional_code_id, :user_id, presence: true
    validates :promotional_code, uniqueness: true
  end
end
