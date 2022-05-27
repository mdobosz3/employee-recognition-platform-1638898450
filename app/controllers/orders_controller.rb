# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    if %w[delivered not_delivered].include?(params[:status])
      render :index,
             locals: { orders: Order.filter_by_status(params[:status]).where(employee: current_employee).includes(:employee,
                                                                                                                  :address) }
    else
      render :index, locals: { orders: Order.where(employee: current_employee).includes(:employee, :address) }
    end
  end

  def new
    @reward = Reward.find(params[:reward])
    if current_employee.kudo_points < @reward.price
      redirect_to rewards_path, notice: "You don't have enough kudos."
    else
      @order = Order.new
      @order.build_address
    end
  end

  def create
    if params[:order].nil?
      reward = Reward.find(params[:reward])
      if current_employee.kudo_points < reward.price
        redirect_to rewards_path, notice: "You don't have enough kudos to buy this reward."
      else
        order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward)
        order.save
        redirect_to rewards_path, notice: 'Reward was successfully buying.'
      end

    else
      @reward = Reward.find(params[:order][:reward_id])
      if current_employee.kudo_points < @reward.price
        redirect_to rewards_path, notice: "You don't have enough kudos to buy this reward."
      else
        @order = Order.new(order_params)
        @order.reward_snapshot = @reward
        if @order.save
          redirect_to rewards_path, notice: 'Reward was successfully buying.'
        else
          render :new
        end
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:employee_id, :reward_id, :reward_snapshot, address_attributes: %i[street postcode city])
  end
end
