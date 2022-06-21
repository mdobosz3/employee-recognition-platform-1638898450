class CreateRewardCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :reward_codes do |t|
      t.string :code, null: false
      t.integer :sale, default: 0
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
