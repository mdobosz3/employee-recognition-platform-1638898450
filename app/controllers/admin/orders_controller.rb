# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      # render index, locals: { orders: Order.includes(:employee).all.order(:status) }
      @orders = Order.includes(:employee).all.order(:status)

      # respond_to do |format|
      #  format.html
      #  format.csv { send_data @orders.to_csv, filename: "orders-#{Date.today}.csv" }
      # end

      respond_to do |format|
        format.html
        # render :template => 'admin/orders/index.html.erb'
        format.csv do
          response.headers['Content-Type'] = 'text/csv'
          response.headers['Content-Disposition'] = "attachment; filename=orders-#{Date.today}.csv"
          render template: 'admin/orders/export.csv.erb'
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
