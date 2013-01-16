module PlazrStore
  # Controller for interacting with the store's pages
  class PagesController < ApplicationController

    # Get the featured, best and recomended product to display in the index page of the store
    def index
    	@featured = Product.last
    	@best = Product.find(:all, :limit => 5, :order=> 'created_at desc')
    	@recommended = Product.find(:all, :limit => 4, :order=> 'created_at desc')
    end

    # Get a specific page to display from a given slug (name)
    def show
      @page = Page.find_by_slug(params[:slug])
    end
  end

end
