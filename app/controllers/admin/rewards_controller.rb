# frozen_string_literal: true

module Admin
  class RewardsController < AdminController
    def index
      render :index, locals: { rewards: Reward.all }
    end

    def import
      if Reward.import(params[:file])
        redirect_to admin_rewards_path, notice: 'Rewards was successfully imported.'
      else
        redirect_to admin_rewards_path,
                    notice: 'Rewards were not imported. Check the data entered in the "slug" column and try again.'
      end
    end

    def show
      render :show, locals: { reward: reward }
    end

    def new
      render :new, locals: { reward: Reward.new }
    end

    def edit
      render :edit, locals: { reward: reward }
    end

    def create
      reward = Reward.new(reward_params)
      reward.slug = reward.title.parameterize
      if reward.save
        redirect_to admin_rewards_path(reward), notice: 'Reward was successfully created.'
      else
        render :new, locals: { reward: reward }
      end
    end

    def update
      reward.slug = reward_params[:title].parameterize
      if reward.update(reward_params)
        redirect_to admin_rewards_path(reward), notice: 'Reward was successfully updated.'
      else
        render :edit, locals: { reward: reward }
      end
    end

    def destroy
      reward.destroy
      redirect_to admin_rewards_url, notice: 'Reward was successfully destroyed.'
    end

    private

    def reward
      @reward ||= Reward.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :photo, :delivery_method, category_ids: [])
    end
  end
end
