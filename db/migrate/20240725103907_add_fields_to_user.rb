class AddFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :donors, :photo, :string
    add_column :users, :photo, :string
  end
end
