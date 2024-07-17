class CreateDonorHandbooks < ActiveRecord::Migration[7.1]
  def change
    create_table :donor_handbooks do |t|
      t.integer :center_id
      t.text :description

      t.timestamps
    end
  end
end
