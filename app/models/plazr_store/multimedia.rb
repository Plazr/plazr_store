module PlazrStore
  class Multimedia < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :page
    belongs_to :multimedia_type

    ## Attributes ##
    attr_accessible :caption, :link, :size
  end
end
