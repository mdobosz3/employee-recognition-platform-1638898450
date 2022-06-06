# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    if %w[delivered not_delivered].include?(params[:status])
      render :index,
             locals: { orders: Order.filter_by_status(params[:status]).where(employee: current_employee).includes(:employee, :address) }
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
    # delivered by email
    if params[:order].nil?
      reward = Reward.find(params[:reward])
      if current_employee.kudo_points < reward.price
        redirect_to rewards_path, notice: "You don't have enough kudos to buy this reward."
      elsif RewardCode.where(reward_id: reward.id, sale: "unused").count > 0

        begin
          ActiveRecord::Base.transaction do
            reward_code = RewardCode.where(reward_id: reward.id, sale: "unused").first
            order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward, status: 'delivered')
            order.save!
            reward_code.update!(order: order, sale: 'used')
            
          end
          binding.pry
          OrderDeliveryMailer.with(order: order).delivery_email.deliver_now
          redirect_to rewards_path, notice: 'Reward was successfully buying, check your email.'
        rescue ActiveRecord::RecordNotSaved  => e
          redirect_to rewards_path, notice: "Something go wrong. Please try again. #{e.message}"
        end

      else
        redirect_to rewards_path, notice: 'This Reward is currently unavailable.'
      end
    # delivered by post
    else
      @reward = Reward.find(params[:order][:reward_id])
      if current_employee.kudo_points < @reward.price
        redirect_to rewards_path, notice: "You don't have enough kudos to buy this reward."
      else
        @order = Order.new(order_params)
        @order.employee_id = current_employee.id
        @order.reward_snapshot = @reward
        if @order.save
          redirect_to rewards_path, notice: 'Reward was successfully buying.'
        else
          redirect_to orders_path, notice: 'Order was not processed.'
        end
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:employee_id, :reward_id, :reward_snapshot, address_attributes: %i[street postcode city])
  end
end
