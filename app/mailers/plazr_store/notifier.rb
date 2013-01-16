module PlazrStore
  # Mailer class for sending notifications to the users
  class Notifier < ActionMailer::Base
    default :from => "notification@example.com"

    # Notifies the user by email of the order that was made
    def order_notification(order)
      @order = order
      mail(:to => @order.email, :subject => "Order ##{@order.id}")
    end
  end
end
