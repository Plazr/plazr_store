module PlazrStore
  class Property < ActiveRecord::Base
    ## Relations ##
    has_and_belongs_to_many :prototype

    ## Attributes ##
    attr_accessible :active, :name_display, :name_id
  end
end
