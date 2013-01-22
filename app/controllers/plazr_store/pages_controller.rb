module PlazrStore
  class PagesController < ApplicationController

    def index
    	@featured = Product.last
    	@best = Product.find(:all, :limit => 3, :order=> 'created_at desc')
    	@recommended = Product.find(:all, :limit => 8, :order=> 'created_at desc')
    end

    def show
      @page = Page.find_by_slug(params[:slug])
    end
  end

end
