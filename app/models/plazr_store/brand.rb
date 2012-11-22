module PlazrStore
  class Brand < ActiveRecord::Base
    ## Relations ##
    has_many :products

    ## Attributes ##
    attr_accessible :name

    # Validations
    validates_presence_of :name
  end
end
