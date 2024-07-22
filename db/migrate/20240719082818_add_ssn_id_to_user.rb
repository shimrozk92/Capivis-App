class AddSsnIdToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :ssn_id, :string
    add_index :users, :ssn_id, unique: true
  end
end
