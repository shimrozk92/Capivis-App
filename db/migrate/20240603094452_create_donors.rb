class CreateDonors < ActiveRecord::Migration[7.1]
  def change
    create_table :donors do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.date :birthdate
      t.string :gender
      t.string :zipcode
      t.string :phone_number
      t.string :alternate_phone_number
      t.string :city
      t.string :state
      t.string :country
      t.string :language
      t.string :address_line_1
      t.string :address_line_2
      t.text :document
      t.datetime :arrival_datetime

      t.timestamps
    end
  end
end
