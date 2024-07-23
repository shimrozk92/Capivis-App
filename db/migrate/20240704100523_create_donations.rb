class CreateDonations < ActiveRecord::Migration[7.1]
  def change
    create_table :donations do |t|
      t.integer :donor_id
      t.integer :center_id
      t.text :cancellation_reason
      t.string :status

      t.timestamps
    end
  end
end
