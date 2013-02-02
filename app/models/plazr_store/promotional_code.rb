module PlazrStore
  class PromotionalCode < ActiveRecord::Base
    ## Relations ##
    belongs_to :discount_type

    has_many :orders
    has_one :coupon

    ## Attributes ##
    attr_accessible :code, :description, :discount_type_id, :expires_at, :minimum_cart, :starts_at, :times_used, :uses_allowed, :value

    ## Validations ##
    validates :code, :presence => true
    validates :value, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :minimum_cart, numericality: {:greater_than_or_equal_to => 0, :allow_blank => true}
    validates :times_used, numericality: {:greater_than_or_equal_to => 0, :allow_blank => true}
    validates :uses_allowed, numericality: {:greater_than_or_equal_to => -1, :allow_blank => true}
    validates :starts_at, :presence => true
    validate :start_before_expire

    def start_before_expire
      return unless starts_at and expires_at
      errors.add(:starts_at, "needs to be minor or equal to the expire date") unless starts_at < expires_at
    end

  end
end
