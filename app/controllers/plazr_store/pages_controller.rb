module PlazrStore
	class PagesController < ApplicationController
		def index
			@featured = Product.last
			@recommended = Product.find(:all, :limit => 4, :order=> 'created_at desc')
		end
		def about

		end
		def search

		end
	end
end
