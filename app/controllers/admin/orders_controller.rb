# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController
    def index
      render :index, locals: { orders: Order.includes(:employee).all }
    end
  end
end
