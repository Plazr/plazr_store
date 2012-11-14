module PlazrStore
  class Page < ActiveRecord::Base
    ## Relations ##
    has_many :multimedia

    ## Attributes ##
    attr_accessible :content, :slug, :title
  end
end
