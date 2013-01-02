module PlazrStore
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
    
    # this model need to have a variant or a page association
    validates :variant, :presence => true, :if => :page_nil?
    validates :page, :presence => true, :if => :variant_nil?
    validates_attachment_presence :file
    validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 
                  'image/gif', 'video/avi', 'video/mpeg', 'video/quicktime', 'video/mp4']
    
    
    ## Instance Methods ##
    #method to check if page association is nil
    def page_nil?
      self.page.nil?
    end

    #method to check if variant association is nil
    def variant_nil?
      self.variant.nil?
    end

    #set the path where the files are going to be stored based on the model to which the file belongs
    def set_path_based_on_parent!
      if !variant_nil?
        ":rails_root/public/assets/upload/variants/:id/:style/:basename.:extension"
      elsif !page_nil?
        ":rails_root/public/assets/upload/pages/:id/:style/:basename.:extension"
      end
    end

    #set the url where the files are going to be accessed based on the model to which the file belongs
    def set_url_base_on_parent!
      if !variant_nil?
        "/assets/upload/variants/:id/:style/:basename.:extension"
      elsif !page_nil?
        "/assets/upload/pages/:id/:style/:basename.:extension"
      end
    end

    def self.multimedia_from_all_variants_of_a_product(product)
      where(:variant_id => Variant.where(:product_id => product).map(&:id))
    end

    protected

      def default_url_method
        if self.type == 'variant'
          "/assets/no_image_avail/#{self.type}.png"
        else
          "/assets/no_image/avail/generic.png"
        end
      end

  end
end
