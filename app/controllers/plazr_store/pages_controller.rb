module PlazrStore
  class PagesController < ApplicationController

	def index
		@featured = Product.last
		@recommended = Product.find(:all, :limit => 4, :order=> 'created_at desc')
	end

    def show
      @page = Page.find_by_slug(params[:slug])
    end
  end

end
