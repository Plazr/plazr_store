module PlazrStore
  class MultimediaType < ActiveRecord::Base
    ## Relations ##
    has_many :multimedia, class_name: "Multimedia"

    ## Attributes ##
    attr_accessible :description
  end
end
