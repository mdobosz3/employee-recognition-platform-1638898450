# frozen_string_literal: true

module Admin
  class RewardCodesController < AdminController
    def edit
      render :edit, locals: { reward_code: reward_code }
    end

    def create
      reward_code = RewardCode.new(reward_code_params)
      if reward_code.save
        redirect_to admin_rewards_path, notice: 'Reward was successfully created.'
      else
        render :new, locals: { reward_code: reward_code }
      end
    end

    def update
      if reward_code.update(reward_code_params)
        redirect_to admin_rewards_path, notice: 'Reward was successfully updated.'
      else
        render :edit, locals: { reward: reward_code }
      end
    end

    def destroy
      reward_code.destroy
      redirect_to admin_rewards_url, notice: 'Reward code was successfully destroyed.'
    end

    private

    def reward_code
      @reward_code ||= RewardCode.find(params[:id])
    end

    def reward_code_params
      params.require(:reward_code).permit(:code, :status, :reward_id)
    end
  end
end
