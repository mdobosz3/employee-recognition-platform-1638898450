# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    if %w[delivered not_delivered].include?(params[:status])
      render :index, locals: { orders: Order.filter_by_status(params[:status]).where(employee: current_employee) }
    else
      render :index, locals: { orders: Order.where(employee: current_employee) }
    end
  end

  def create
    if current_employee.kudo_points < reward.price
      redirect_to rewards_path, notice: "You don't have enough kudos."
    else
      order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward)
      order.save
      redirect_to rewards_path, notice: 'Reward was successfully buying.'
    end
  end

  private

  def reward
    Reward.find(params[:reward])
  end
end
