module PlazrStore
  # Class representing a media file, such as an image, for a product or page
  class Multimedium < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :page

    ## Attributes ##
    attr_accessible :file, :caption, :variant_id, :type

    ## Paperclip ##
    has_attached_file :file, :styles => { :thumb => "300x300"},
      :url  => :set_url_base_on_parent!, 
      :path => :set_path_based_on_parent!,
      :default_url => :default_url_method
    
    # This model needs to have a variant or a page association
    validates :variant, :presence => true, :if => :page_nil?
    validates :page, :presence => true, :if => :variant_nil?
    validates_attachment_presence :file
    validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 
                  'image/gif', 'video/avi', 'video/mpeg', 'video/quicktime', 'video/mp4']
    
    
    ## Instance Methods ##
    
    # Check if it is associated to a page
    def page_nil?
      self.page.nil?
    end

    # Check if it is associated to a variant (product)
    def variant_nil?
      self.variant.nil?
    end

    # Set the path where the files are going to be stored based on the model to which the file belongs
    def set_path_based_on_parent!
      if !variant_nil?
        ":rails_root/public/assets/upload/variants/:id/:style/:basename.:extension"
      elsif !page_nil?
        ":rails_root/public/assets/upload/pages/:id/:style/:basename.:extension"
      end
    end

    # Set the url where the files are going to be accessed based on the model to which the file belongs
    def set_url_base_on_parent!
      if !variant_nil?
        "/assets/upload/variants/:id/:style/:basename.:extension"
      elsif !page_nil?
        "/assets/upload/pages/:id/:style/:basename.:extension"
      end
    end

    # Get all the multimedia associated to all variants of a given product
    def self.multimedia_from_all_variants_of_a_product(product)
      where(:variant_id => Variant.where(:product_id => product).map(&:id))
    end

    protected
      # Set the default URL for the multimedia
      def default_url_method
        if self.type == 'variant'
          "/assets/no_image_avail/#{self.type}.png"
        else
          "/assets/no_image/avail/generic.png"
        end
      end

  end
end
