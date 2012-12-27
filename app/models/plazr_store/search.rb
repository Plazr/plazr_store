module PlazrStore
  class Search
    ## Class Methods ##
    def self.search(search)
      if search
        # matcher = FuzzyMatch.new(model.all, :read => :name) # Product#name will be called when comparing
        # TODO allow search for categories and brand
        Product.where('name LIKE ? OR details LIKE ?', "%#{search}%", "%#{search}%")
      else
        # returns Product.all in a scope so it can be queriable
        Product.scoped
      end
    end
  end
end
