class RenameSaleToStatus < ActiveRecord::Migration[6.1]
  def change
    rename_column :reward_codes, :sale, :status
  end
end
