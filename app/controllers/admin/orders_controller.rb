# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.includes(:employee).all.order(:status)

      respond_to do |format|
        format.html
        format.csv do
          response.headers['Content-Type'] = 'text/csv'
          response.headers['Content-Disposition'] = "attachment; filename=Orders-#{Time.zone.today}.csv"
          render template: 'admin/orders/export', handlers: [:erb], formats: [:csv]
        end
      end
    end

    def update
      if order.delivered?
        redirect_to admin_orders_path, notice: 'Order was already delivered'
      elsif order.update(status: :delivered)
        OrderDeliveryMailer.with(order: order).delivery_email.deliver_now
        redirect_to admin_orders_path, notice: 'Order was successfully delivered.'
      else
        redirect_to admin_orders_path, notice: 'Order was not delivered'
      end
    end

    private

    def order
      @order = Order.find(params[:id])
    end
  end
end
