module PlazrStore
  class SearchController < ApplicationController
    def search
      # params[:min_price]
      # params[:max_price]
      # params[:brand]
      # params[:price]
      # params[:category]
      @products = Search.search(params).paginate(:per_page => 20, :page => params[:page])
      @brands = Brand.joins(:products).where("plazr_store_products.id IN (?)", @products.map(&:id)).uniq
    end
  end
end
