class AddCenterToDonorScreenings < ActiveRecord::Migration[7.1]
  def change
    add_reference :donor_screenings, :center, foreign_key: true
  end
end
