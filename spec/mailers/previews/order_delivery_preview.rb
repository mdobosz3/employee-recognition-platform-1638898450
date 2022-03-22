# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/order_delivery
class OrderDeliveryPreview < ActionMailer::Preview
  def delivery_email
    OrderDeliveryMailer.with(order: order).delivery_email
  end
end
