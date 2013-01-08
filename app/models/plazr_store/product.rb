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

    has_many :product_properties, :dependent => :destroy
    has_many :properties, :through => :product_properties

    has_many :product_product_categories, :dependent => :destroy, :inverse_of => :product
    has_many :product_categories, :through => :product_product_categories

    has_many :product_variant_properties, :dependent => :destroy
    has_many :variant_properties, :through => :product_variant_properties

    ## Attributes ##
    ### Merging 'develop' into 'mockup'
    ### PC, 7 Jan 2013 13:14
    ### TODO: clean this up
    ### The following code was in 'mockup'
    # attr_accessible :details, :name, :slug, :rating, :brand_id,
    #                 ### TODO: clean this up, conflict merging develop into mockup (PC, 29 Dez 2012 16:28)
    #                 ### this was in the mockup branch
    #                 # :property_ids, :variant_property_ids,
    #                 # :variants_attributes, :product_variant_properties_attributes,
    #                 # :product_properties_attributes, :brand_attributes, :prototypes
    #                 ### this was in the develop branch
    #                 :property_ids, :variant_property_ids,
    #                 :variants_attributes, :product_variant_properties_attributes,
    #                 :product_properties_attributes, :brand_attributes,
    #                 :available_at_date_string, :available_at_time_string
    ### The following code was in 'develop'
    attr_accessible :available_at, :details, :name, :slug, :rating, :brand_id,
                    :property_ids, :variant_property_ids,
                    :variants_attributes, :product_variant_properties_attributes,
                    # :product_properties_attributes, :brand_attributes,
                    :brand_attributes,
                    :product_product_categories_attributes

    # Nested Attributes
    accepts_nested_attributes_for :variants, :allow_destroy => true
    accepts_nested_attributes_for :product_product_categories, :allow_destroy => true
    accepts_nested_attributes_for :product_variant_properties, :allow_destroy => true
    ### TODO: clean this up, conflict merging develop into mockup (PC, 29 Dez 2012 16:28)
    ### this was in the mockup branch
    #accepts_nested_attributes_for :product_properties, :allow_destroy => true
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
      # self.variants.master_variant.first.price
      self.master_variant.price
    end

    def images
      master_variant.multimedia
    end

    # def sku
    #   self.variants.master_variant.first.sku
    # end

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


    ### Virtual attributes

    # => Getter for date
    # => This is required in order to use the datepicker to set the available_at field
    def available_at_date_string
      @available_at_date_string || (available_at || created_at || Time.now).to_date.to_s(:db)
    end

    # => Getter for time
    # => This is required in order to use the timepicker to set the available_at field
    def available_at_time_string
      @available_at_time_string || (available_at || created_at || Time.now).to_s(:time)
    end



    # => Setter for date
    # => This is required in order to use the datepicker to set the available_at field
    def available_at_date_string=(date_str)
      @available_at_date_string = date_str
    end

    # => Setter for time
    # => This is required in order to use the timepicker to set the available_at field
    def available_at_time_string=(time_str)
      @available_at_time_string = time_str
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

    def image
      self.master_variant.image
    end

    def related(count = 5)
      #Product.
    end
  end
end
