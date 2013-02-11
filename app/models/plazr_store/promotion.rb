# encoding: utf-8
module PlazrStore
  class Promotion < ActiveRecord::Base
    ## Relations ##
    belongs_to :discount_type

    has_many :product_promotions, :dependent => :destroy, :inverse_of => :promotion
    has_many :products, :through => :product_promotions

    ## Attributes ##
    attr_accessible :description, :expires_at, :min_filter, :name, :starts_at, :type_id, :value, 
                    :discount_type_id, :discount_type_attributes,
                    :product_promotions_attributes

    ## Nested Resources ##
    accepts_nested_attributes_for :discount_type
    accepts_nested_attributes_for :product_promotions, :allow_destroy => true

    ## Validations ##
    validates :name, :presence => true
    validates :discount_type, :presence => true
    validates :value, presence: true, numericality: {:greater_than_or_equal_to => 0}
    validates :min_filter, numericality: {:greater_than_or_equal_to => 0, :allow_blank => true}
    validates :starts_at, :presence => true
    validate :start_before_expire

    def start_before_expire
      return unless starts_at and expires_at
      errors.add(:starts_at, "needs to be minor or equal to the expire date") unless starts_at < expires_at
    end

    ## Scopes ##
    scope :active_promotions, lambda{ where("(? BETWEEN starts_at AND expires_at) OR (starts_at <= ? AND expires_at IS NULL) OR (starts_at IS NULL AND ? <= expires_at)", Date.today, Date.today, Date.today) }

    ## Public Methods ##

    def get_unselected_products_and_order_by_name
      # creates an array for all product_promotions that the promotions does not currently have selected
      # and builds them in the promotion
      (Product.all - self.products).each do |p|
        self.product_promotions.build(:product => p) unless self.product_promotions.map(&:product_id).include?(p.id)
      end
      # to ensure that all products are always shown in a consistent order
      self.product_promotions.sort_by! {|x| x.product.name}
    end
    
  end
end
