class AddStateToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :state, :string
  end
end
