module PlazrStore
  class Multimedium < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant

    ## Attributes ##
    attr_accessible :file, :caption, :variant_id, :class_type

    ## Paperclip ##
    has_attached_file :file,
      :styles      => Proc.new { |upload| upload.instance.set_styles },
      :url         => :set_url_base_on_parent!, 
      :path        => :set_path_based_on_parent!,
      :default_url => :default_url_method

    validates_attachment_presence :file
    validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 
                  'image/gif', 'video/avi', 'video/mpeg', 'video/quicktime', 'video/mp4']

    ## Callbacks ##
    before_validation :one_logo, on: :create
    before_validation :one_banner, on: :create

    # just one logo for store
    def one_logo
      if self.class_type == 'logo' && Multimedium.find_all_by_class_type('logo').count > 0
        self.errors.add(:base, "This store already has one logo")
        false
      end
    end

    # just one banner for store
    def one_banner
      if self.class_type == 'banner' && Multimedium.find_all_by_class_type('banner').count > 0
        self.errors.add(:base, "This store already has one banner")
        false
      end
    end
    
    ## Instance Methods ##

    # returns the banner of the store
    def self.banner
      find_by_class_type('banner')
    end

    # returns the logo of the store
    def self.logo
      find_by_class_type('logo')
    end

    # set the style of the file accordingly to the class_type
    def set_styles
      #binding.pry
      if self.class_type == 'variant'
        {:thumb => '300x300!'}
      elsif self.class_type == 'banner'
        {:banner => '100x75!'}
      elsif self.class_type == 'logo'
        {:logo => '100x75!'}
      end
    end

    #set the path where the files are going to be stored based on the class_type
    def set_path_based_on_parent!
      if self.class_type == 'variant'
        ":rails_root/public/assets/upload/variants/:id/:style/:basename.:extension"
      elsif self.class_type == 'banner'
        ":rails_root/public/assets/upload/banner/:id/:style/:basename.:extension"
      elsif self.class_type == 'logo'
        ":rails_root/public/assets/upload/logo/:id/:style/:basename.:extension"
      end
    end

    #set the url where the files are going to be accessed based on the class_type
    def set_url_base_on_parent!
      if self.class_type == 'variant'
        "/assets/upload/variants/:id/:style/:basename.:extension"
      elsif self.class_type == 'banner'
        "/assets/upload/banner/:id/:style/:basename.:extension"
      elsif self.class_type == 'logo'
        "/assets/upload/logo/:id/:style/:basename.:extension"
      end
    end

    def self.multimedia_from_all_variants_of_a_product(product)
      where(:variant_id => Variant.where(:product_id => product).map(&:id))
    end

    protected
      def default_url_method
        if self.class == 'variant'
          "/assets/no_image_avail/#{self.class_type}.png"
        else
          "/assets/no_image/avail/generic.png"
        end
      end

  end
end
