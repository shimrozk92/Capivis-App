class AddfieldsToUser < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :address_line_1, :string
    add_column :users, :birthdate, :string
  end
end
