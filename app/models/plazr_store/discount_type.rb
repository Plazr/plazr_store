# encoding: utf-8
module PlazrStore
  class DiscountType < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface
    ## Relations ##
    has_many :promotions
    has_many :promotional_codes

    ## Attributes ##
    attr_accessible :description, :name, :scope

    ## Validations ##
    validates :name, :presence => true, uniqueness_without_deleted: true
    # scope is 0 if belongs both to PromotionalCode and to Promotion
    # scope is 1 if belongs only to PromotionalCode
    # scope is 2 if belongs only to Promotion
    validates :scope, :inclusion => 0..2

    ## Scopes ##
    scope :promotion_types, where(:scope => [0,2])
    scope :promotional_code_types, where(:scope => [0,1])
  end
end
