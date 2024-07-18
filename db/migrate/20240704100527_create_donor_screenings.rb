class CreateDonorScreenings < ActiveRecord::Migration[7.1]
  def change
    create_table :donor_screenings do |t|
      t.string :acceptable_arm_check
      t.string :donor_height
      t.string :donor_weight
      t.string :donor_blood_pressure
      t.string :donor_temperature
      t.string :fingerstick_timestamp
      t.string :hematocrit
      t.string :total_protein

      t.timestamps
    end
  end
end
