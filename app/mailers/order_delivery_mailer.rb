# frozen_string_literal: true

class OrderDeliveryMailer < ApplicationMailer
  def delivery_email
    @order = params[:order]
    mail to: @order.employee.email, subject: 'Your order has been delivered'
  end

  def delivery_by_post_email
    @order = params[:order]
    mail to: @order.employee.email, subject: 'Your order has been delivered'
  end
end
