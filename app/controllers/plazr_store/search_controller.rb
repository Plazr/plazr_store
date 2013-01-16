module PlazrStore
  # Controller for interacting with the search model
  class SearchController < ApplicationController
  	# Search all the products with the chosen characteristics from the view
    def search
      @products = Search.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
    end
  end
end
