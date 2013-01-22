module PlazrStore
  module Admin::OrderHelper

    def change_to_paid_form(order_id)
      form_tag pay_admin_order_path(order_id), method: :put do
        submit_tag('Mark as Paid')
      end
    end

    def change_product_to_shipped_form(order_id, product_id)
      form_tag admin_order_ship_product_path(order_id, product_id), method: :put do
        submit_tag('Mark as Shipped')
      end
    end
  end
end
