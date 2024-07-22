class AddProfilableToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :profileable, polymorphic: true
  end
end
