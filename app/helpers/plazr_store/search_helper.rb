module PlazrStore
  module SearchHelper

    def search_form(search)
      form_tag plazr_store.search_path, :method => 'get', :id => "products_search" do
        content_tag :label do
          raw "Search term:" +
            text_field_tag(:search, search) +
            submit_tag( "Search", :name => nil)
        end
      end
    end

  end
end
