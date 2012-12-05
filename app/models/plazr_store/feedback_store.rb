module PlazrStore
  class FeedbackStore < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api
    
    ## Attributes ##
    attr_accessible :comment, :rating
  end
end
