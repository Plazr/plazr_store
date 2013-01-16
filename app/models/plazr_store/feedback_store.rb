module PlazrStore
  # Feedback to a store, given by an user, with an associated comment and rating
  class FeedbackStore < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api
    
    ## Attributes ##
    attr_accessible :comment, :rating
  end
end
