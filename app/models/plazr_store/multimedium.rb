module PlazrStore
  class Multimedium < ActiveRecord::Base
    ## Relations ##
    belongs_to :variant
    belongs_to :page

    ## Attributes ##
    attr_accessible :file, :caption, :variant_id

    ## Nested Attributes ##
    accepts_nested_attributes_for :variant

    ## Paperclip ##
    has_attached_file :file, :styles => { :thumb => "300x300"},
      :url  => :set_url_base_on_parent!, 
      :path => :set_path_based_on_parent!
    
    validates_attachment_presence :file
    validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 
                  'image/gif', 'video/avi', 'video/mpeg', 'video/quicktime', 'video/mp4']
    
    private

    #set the path where the files are going to be stored based on the model to which the file belongs
    def set_path_based_on_parent!
      if !self.variant.nil?
        ":rails_root/public/assets/upload/variants/:id/:style/:basename.:extension"
      elsif !self.page.nil?
        ":rails_root/public/assets/upload/pages/:id/:style/:basename.:extension"
      end
    end

    #set the url where the files are going to be accessed based on the model to which the file belongs
    def set_url_base_on_parent!
      if !self.variant.nil?
        "/assets/upload/variants/:id/:style/:basename.:extension"
      elsif !self.page.nil?
        "/assets/upload/pages/:id/:style/:basename.:extension"
      end
    end

    def self.multimedia_from_all_variants_of_a_product(product)
      where(:variant_id => Variant.where(:product_id => product).map(&:id))
    end
  end
end
