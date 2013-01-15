module PlazrStore
  class Search

    ## Class Methods ##
    def self.search(params)
      # raise
      if params[:search]
        # matcher = FuzzyMatch.new(model.all, :read => :name) # Product#name will be called when comparing

        products = Product.find_by_name_and_details_like(params[:search])
        # TODO mudar factory do product_full para associar product_categories como deve de ser
        products = products.find_by_category(params[:category])
        products = products.find_by_brand(params[:brand])
        products = products.find_by_price_between(params[:min_price], params[:max_price])
        products = products.order_by_price(params[:price])
        products
      else
        # returns Product.all in a scope so it can be queriable
        Product.scoped
      end
    end
  end
end
