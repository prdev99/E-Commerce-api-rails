class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :title, :string
    add_column :users, :about, :string
    add_column :users, :address, :string
  end
end
