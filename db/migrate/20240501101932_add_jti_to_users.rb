# frozen_string_literal: true

# This migration adds a JTI (JSON Web Token Identifier) column to the users table.
class AddJtiToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end
end
