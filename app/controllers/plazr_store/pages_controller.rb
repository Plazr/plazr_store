module PlazrStore
  class PagesController < ApplicationController

    def index
    	@featured = Product.last
    	@best = Product.find(:all, :limit => 4, :order=> 'created_at desc')
    	@recommended = Product.find(:all, :limit => 8, :order=> 'created_at desc')
    end

    def show
      if !!(params[:slug] =~ /^[-+]?[0-9]+$/)
        @page = Page.find(params[:slug])
      else
        @page = Page.find_by_slug(params[:slug])
      end
    end
  end

end
