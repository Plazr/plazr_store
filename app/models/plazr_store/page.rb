module PlazrStore
  class Page < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    has_many :multimedia, class_name: "Multimedia"

    ## Attributes ##
    attr_accessible :content, :slug, :title

    ## Validations ##
    validates :title, presence: true
    validates :slug, uniqueness_without_deleted: true
  end
end
