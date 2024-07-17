class CreateCenters < ActiveRecord::Migration[7.1]
  def change
    create_table :centers do |t|
      t.text :address
      t.string :name
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
