class AddOrderRefToRewardCodes < ActiveRecord::Migration[6.1]
  def change
    add_reference :reward_codes, :order, foreign_key: true
  end
end
