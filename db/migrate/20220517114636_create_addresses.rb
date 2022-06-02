class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :postcode, null: false
      t.string :city, null: false
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
