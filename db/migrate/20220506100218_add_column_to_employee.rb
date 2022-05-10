class AddColumnToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :first_name, :string, default: 'default', null: false
    add_column :employees, :last_name, :string, default: 'default', null: false
  end
end
