class CreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      t.integer :center_id

      t.timestamps
    end
  end
end
