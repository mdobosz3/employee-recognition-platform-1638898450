
class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def create
    if current_employee.kudo_points < reward.price
        redirect_to rewards_path, notice: 'You don`t have enough kudos.'
    else 
        order = Order.new(employee: current_employee, reward: reward)
        order.save
        redirect_to rewards_path, notice: 'Reward was successfully buying.'
    end
  end  
  
  private
  def reward
    Reward.find(params[:reward])
  end

  def order
    @order = Order.find(params[:id])
  end
    
end