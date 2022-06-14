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
    if @reward.reward_codes.unused.exists? == false && @reward.online? == true
      redirect_to rewards_path, notice: 'Sorry, this reward is not available at the moment.'
    elsif current_employee.kudo_points < @reward.price
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
      elsif reward.reward_codes.unused.exists?
        begin
          ActiveRecord::Base.transaction do
            reward_code = RewardCode.where(reward_id: reward.id, status: 'unused').first
            OrderDeliveryMailer.with(order: order).delivery_email.deliver_now
            order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward, status: 'delivered')
            order.save!
            reward_code.update!(order: order, status: 'used')
          end
          redirect_to rewards_path, notice: 'Reward was successfully purchuased, check your email.'
        rescue ActiveRecord::RecordNotSaved => e
          redirect_to rewards_path, notice: "Something has gone wrong. Please try again. #{e.message}"
        end
      else
        redirect_to rewards_path, notice: 'Sorry, this reward is not available at the moment.'
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
