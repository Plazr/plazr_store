module PlazrStore
  module Admin::OrderHelper

    def change_to_paid_form(order_id)
      form_tag pay_admin_order_path(order_id), method: :put do
        submit_tag 'Marcar como Pago', :class => [:btn, 'btn-success', 'btn-mini']
      end
    end

    def change_product_to_shipped_form(order_id, product_id)
      form_tag admin_order_ship_product_path(order_id, product_id), method: :put do
        submit_tag 'Marcar como Enviado', :class => [:btn, 'btn-success', 'btn-mini']
      end
    end

    def order_state_to_class (order_state)
      case order_state
      when 'processing'
        'warning'
      when 'cancelled'
        'error'
      when 'completed'
        'success'
      else
        'info'
      end
    end

    def order_state_en_to_pt (order_state)
      case order_state
      when 'processing'
        'Processamento'
      when 'cancelled'
        'Cancelada'
      when 'completed'
        'Completa'
      end
    end
  end
end
