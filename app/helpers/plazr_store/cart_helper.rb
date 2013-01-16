module PlazrStore
  module CartHelper

  	# Helper method to add a product variant to the shopping cart from a view form
    def add_to_cart_form(variant_id)
      form_tag cart_add_path(variant_id), method: :post do
        select_tag('amount', options_for_select((1..10).to_a)) +
        submit_tag('Add to Cart')
      end
    end

  end
end
