# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController
    def index
      render :index, locals: { orders: Order.all }
    end
  end
end
