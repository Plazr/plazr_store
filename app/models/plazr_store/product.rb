module PlazrStore
  class Product < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    belongs_to :brand

    has_many :feedback_products
    # Specifying the :inverse_of option on associations lets you tell Active Record about inverse relationships and it will optimise object loading
    # It also allows to create a product and a variant belonging to it at the same time, because of presence of product_id validation on variation
    has_many :variants, :dependent => :destroy, :inverse_of => :product

    has_many :product_promotions, :dependent => :destroy
    has_many :promotions, :through => :product_promotions

    has_many :product_properties, :dependent => :destroy
    has_many :properties, :through => :product_properties

    has_many :product_product_categories, :dependent => :destroy, :inverse_of => :product
    has_many :product_categories, :through => :product_product_categories

    has_many :product_variant_properties, :dependent => :destroy
    has_many :variant_properties, :through => :product_variant_properties

    ## Attributes ##
    attr_accessible :available_at, :details, :name, :slug, :rating, :brand_id,
                    :property_ids, :variant_property_ids,
                    :variants_attributes, :product_variant_properties_attributes,
                    :brand_attributes,
                    :product_product_categories_attributes,
                    :available_at_date_string, :available_at_time_string

    # Nested Attributes
    accepts_nested_attributes_for :variants, :allow_destroy => true
    accepts_nested_attributes_for :product_product_categories, :allow_destroy => true
    accepts_nested_attributes_for :product_variant_properties, :allow_destroy => true
    accepts_nested_attributes_for :brand

    ## Validations ##
    validates :name, presence: true, uniqueness_without_deleted: true
    validates :slug, presence: true, uniqueness_without_deleted: true

    ## Callbacks ##
    before_save :create_available_at
    before_validation :create_slug


    ## Instance Methods ##
    def has_master?
      self.variants.count >= 1
    end

    def comments
      self.feedback_products.all
    end

    def master_variant
      variants.where(:is_master => true).first
    end

    def master_price
      self.master_variant.price
    end

    def formatted_master_price
      self.master_variant.formatted_price
    end

    def images
      master_variant.multimedia
    end

    def variants_without_master
      self.variants.without_master
    end

    def has_variants?
      self.variants_without_master.count >= 1
    end

    def get_unselected_product_categories_and_order_by_name
      # creates an array for all product_categories that the product does not currently have selected
      # and builds them in the product
      #(VariantCategory.all - self.variant_categories).each do |vc|
      #  self.variant_variant_categories.build(:variant_category => vc) unless self.variant_variant_categories.map(&:variant_category_id).include?(vc.id)
      #end
      # to ensure that all variant_categories are always shown in a consistent order
      #self.variant_variant_categories.sort_by! {|x| x.variant_category.name}
      ProductCategory.parent_categories.sort_by! { |x| x.name }
      ProductCategory.parent_categories.each do |pc|
        self.product_product_categories.build(:product_category => pc)# unless self.variant_variant_categories.map(&:variant_category_id).include?(vc.id)
        pc.child_product_categories.sort_by! { |x| x.name }
        pc.child_product_categories.each do |cpc|
          exist = ProductProductCategory.find_by_product_id_and_product_category_id(self.id, cpc.id)
          #if !exist
            self.product_product_categories.build(:product_category => cpc) unless self.product_product_categories.map(&:product_category_id).include?(cpc.id)
          #else
          #end
        end
      end
    end

    def get_unselected_variant_properties_and_order_by_name
      # creates an array for all variant_properties that the product does not currently have selected
      # and builds them in the product
      (VariantProperty.all - self.variant_properties).each do |var_prop|
        self.product_variant_properties.build(:variant_property => var_prop) unless self.product_variant_properties.map(&:variant_property_id).include?(var_prop.id)
      end
      # to ensure that all variant_properties are always shown in a consistent order
      self.product_variant_properties.sort_by! {|x| x.variant_property.display_name }
    end

    def create_all_properties_association(prototype_id)
      # replicate each property related to the prototype to the product
      Prototype.find(prototype_id).properties.each do |prop|
        self.product_properties.create :property => prop, :value => 0
      end
    end


    def create_all_variant_properties_association(prototype_id)
      # replicate each variant_property related to the prototype to the product
      Prototype.find(prototype_id).variant_properties.each do |vp|
        self.product_variant_properties.create :variant_property => vp
      end
    end

    def image
      self.master_variant.image if self.master_variant
    end

    def related(count = 4)
      categories = self.product_categories.count
      if categories > 0
        self.product_categories[rand(categories)].products.limit(count)
      else
        []
      end
    end

    ### Virtual attributes

    # Getter for date
    # This is required in order to use the datepicker to set the available_at field
    def available_at_date_string
      @available_at_date_string || (available_at || created_at || Time.now).to_date.to_s(:db)
    end

    # Getter for time
    # This is required in order to use the timepicker to set the available_at field
    def available_at_time_string
      @available_at_time_string || (available_at || created_at || Time.now).to_s(:time)
    end



    # Setter for date
    # This is required in order to use the datepicker to set the available_at field
    def available_at_date_string=(date_str)
      @available_at_date_string = date_str
    end

    # Setter for time
    # This is required in order to use the timepicker to set the available_at field
    def available_at_time_string=(time_str)
      @available_at_time_string = time_str
    end

    def rating_count
      self.feedback_products.where('rating IS NOT NULL').count
    end

    def ratings?
      rating_count > 0
    end

    def update_rating
      avg = self.feedback_products.where('rating IS NOT NULL').average(:rating)
      self.update_attribute :rating, avg
    end

    def rating_truncated
      unless rating.nil?
        self.rating.truncate
      else
        0
      end
    end


    ## Class Methods ##
    # Finds products by brand
    def self.find_by_brand(brand_id)
      if !brand_id.blank?
        joins(:brand).where('plazr_store_brands.id' => "#{brand_id}")
      else
        self.scoped
      end
    end

    # Finds products by category
    def self.find_by_category(category_id)
      if !category_id.blank?
        cat = ProductCategory.find(category_id)
        if cat.is_child?
          joins(:product_categories).where('plazr_store_product_categories.id' => category_id)
        else
          # if the category selected is a parent then it will search through all children categories
          joins(:product_categories).where('plazr_store_product_categories.id IN (?)', cat.children.map(&:id))
        end
      else
        self.scoped
      end
    end

    # Finds products by name details using % wildcard
    def self.find_by_name_and_details_like(search)
      where('plazr_store_products.name LIKE ? OR plazr_store_products.details LIKE ?', "%#{search}%", "%#{search}%")
    end

    # Find products by a price range
    def self.find_by_price_between(min, max)
      min = min.to_i
      max = max.to_i
      if max > 0 && (min <= max)
        joins(:variants).where("is_master = ? AND price BETWEEN ? AND ?", true, min, max)
      else
        self.scoped
      end
    end

    # Orders products by price
    def self.order_by_price(direction)
      if direction == "-1"
        joins(:variants).where("is_master = ?", true).order("price DESC")
      elsif direction == "1"
        joins(:variants).where("is_master = ?", true).order("price ASC")
      else
        self.scoped
      end
    end

    # Returns true if any variant of the product has a variant_property_value
    def variants_have_property_values?
      self.variants.each do |v|
        return true if !v.variant_variant_property_values.empty?
      end
      return false
    end

    protected

    def create_available_at
      self.available_at = if @available_at_date_string && @available_at_time_string
        Time.parse("#{@available_at_date_string} #{@available_at_time_string}")
      else
        Time.current
      end
    end

    def create_slug
      self.slug = (self.name || '').parameterize
    end

  end
end
