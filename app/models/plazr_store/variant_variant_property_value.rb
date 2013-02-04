module PlazrStore
  class VariantVariantPropertyValue < ActiveRecord::Base
    
    ## Relations ##
    belongs_to :variant
    belongs_to :variant_property_value

    ## Atributes ##
    attr_accessible :variant_id, :variant_property_value_id, :variant_property_value
    
    ## Callbacks ##
    before_save :must_have_value

    def must_have_value
      if self.variant_property_value_id.blank?
        self.variant.errors.add(:base, "Precisa atribuir um valor para a propriedade deste variante")
        false
      end
    end
  end
end
