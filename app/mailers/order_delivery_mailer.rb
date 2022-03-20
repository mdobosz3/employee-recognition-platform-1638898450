class OrderDeliveryMailer < ApplicationMailer

    def delivery_email
     # @order = params[:order]
      mail(to: order.employee.email, subject: 'Your order has been delivered')
     # mail(to: @order.employee.email, subject: '#{@order.reward_snapshot.title}Welcome to My Awesome Site')
    end
  end
