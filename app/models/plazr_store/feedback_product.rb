module PlazrStore
  class FeedbackProduct < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api
    belongs_to :product
    belongs_to :order
    
    ## Attributes ##
    attr_accessible :comment, :rating
  end
end
