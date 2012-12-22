module PlazrStore
  class SearchController < ApplicationController
    def search
      @products = Search.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
    end
  end
end
