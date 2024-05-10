# frozen_string_literal: true

# This migration adds a name column to the users table.
class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :integer, default: 0
  end
end
