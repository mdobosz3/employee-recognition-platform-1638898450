# frozen_string_literal: true

class RewardsController < ApplicationController
  REWARDS_PER_PAGE = 10

  def index
    @page = params.fetch(:page, 0).to_i
    if params[:category_id].to_i.positive?
      @number_of_pages = (RewardSearch.new(params).results.count / REWARDS_PER_PAGE).ceil
      if params[:page].to_i <= @number_of_pages
        render :index, locals: { rewards: RewardSearch.new(params).results.offset(@page * REWARDS_PER_PAGE).limit(REWARDS_PER_PAGE) }
      else
        redirect_to rewards_path, notice: "Enter page in range 1 to #{@number_of_pages + 1}."
      end
    else
      @number_of_pages = (RewardSearch.new.results.count / REWARDS_PER_PAGE).ceil
      if params[:page].to_i <= @number_of_pages
        render :index, locals: { rewards: RewardSearch.new.results.offset(@page * REWARDS_PER_PAGE).limit(REWARDS_PER_PAGE) }
      else
        redirect_to rewards_path, notice: "Enter page in range 1 to #{@number_of_pages + 1}."
      end
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
