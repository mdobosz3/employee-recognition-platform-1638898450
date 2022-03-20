# frozen_string_literal: true

class OrderDeliveryMailer < ApplicationMailer
  def delivery_email
    mail(to: order.employee.email, subject: 'Your order has been delivered')
  end
end
