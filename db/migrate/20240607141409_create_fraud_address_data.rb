class CreateFraudAddressData < ActiveRecord::Migration[7.1]
  def change
    create_table :fraud_address_data do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
