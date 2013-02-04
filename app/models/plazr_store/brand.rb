# encoding: utf-8
module PlazrStore
  class Brand < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :products

    ## Attributes ##
    attr_accessible :name

    # Validations
    validates :name, presence: true
  end
end
