module PlazrStore
  ### Merging 'develop' into mockup
  ### The following commented code was in 'mockup'
  ### TODO: cleanup if not needed
  ### PC, 7 Jan 2013
	# class PagesController < ApplicationController
	# 	def index
	# 		@featured = Product.last
	# 		@recommended = Product.find(:all, :limit => 4, :order=> 'created_at desc')
	# 	end
	# 	def about

	# 	end
	# 	def search

	# 	end
	# end
  ### The following code was in 'develop'
  class PagesController < ApplicationController
    def show
      @page = Page.find_by_slug(params[:slug])
    end
  end
end
