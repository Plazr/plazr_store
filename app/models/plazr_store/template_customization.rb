module PlazrStore
  class TemplateCustomization < ActiveRecord::Base

    ## Attributes ##
    attr_accessible :id_name, :display_name, :value

    ## Validations ##
    validates :id_name, :presence => true
    validates :id_name, :uniqueness => true

    ## Callbacks ##
    before_save :fill_fields

    def fill_fields
      self.display_name = self.id_name if self.display_name.blank?
    end
  end
end