module PlazrStore
  module CartHelper

    def add_to_cart_form(variant_id)
      form_tag cart_add_path(variant_id), :id => "add_cart_f", method: :post  do
        number_field_tag('amount')
      end
    end

  end
end
