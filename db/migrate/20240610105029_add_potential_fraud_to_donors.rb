class AddPotentialFraudToDonors < ActiveRecord::Migration[7.1]
  def change
    add_column :donors, :potential_fraud, :string
  end
end
