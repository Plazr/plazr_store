# encoding: utf-8
module PlazrStore
  class SearchController < ApplicationController
    def search
      # params[:min_price]
      # params[:max_price]
      # params[:brand]
      # params[:price]
      # params[:category]
      @products = Search.search(params).paginate(:per_page => 20, :page => params[:page])
      #@brands = Brand.joins(:products).where("plazr_store_products.id IN (?)", @products.map(&:id)).uniq
      @brands = Brand.all
    end
  end
end
