# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      render :index, locals: { orders: Order.includes(:employee).all.order(:status)  }
    end

    def update
      order.delivered!
      redirect_to admin_orders_path, notice: 'Order was successfully delivered.'
    end

    private

    def order
      @order = Order.find(params[:id])
    end
  end
end
