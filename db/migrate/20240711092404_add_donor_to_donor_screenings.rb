class AddDonorToDonorScreenings < ActiveRecord::Migration[7.1]
  def change
    add_reference :donor_screenings, :donor, foreign_key: true
    add_column :donor_screenings, :status, :string
  end
end
