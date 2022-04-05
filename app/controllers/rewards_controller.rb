# frozen_string_literal: true

class RewardsController < ApplicationController
  REWARDS_PER_PAGE = 10

  def index
    @page = params.fetch(:page, 0).to_i
    @number_of_page = (Reward.count / REWARDS_PER_PAGE).ceil
    if params[:page].to_i <= @number_of_page
      render :index, locals: { rewards: Reward.offset(@page * REWARDS_PER_PAGE).limit(REWARDS_PER_PAGE) }
    else
      redirect_to rewards_path, notice: "Enter page in range 1 to #{@number_of_page + 1}."
    end
  end

  def show
    render :show, locals: { reward: reward }
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:title, :description, :price)
  end
end
