module PlazrStore
  class Multimedia < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :page

    ## Attributes ##
    attr_accessible :description, :link, :size
  end
end
