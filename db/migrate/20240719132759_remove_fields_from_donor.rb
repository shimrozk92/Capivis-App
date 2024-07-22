class RemoveFieldsFromDonor < ActiveRecord::Migration[7.1]
  def change
    remove_column :donors, :first_name, :string
    remove_column :donors, :last_name, :string
    remove_column :donors, :birthdate, :date
    remove_column :donors, :phone_number, :string
    remove_column :donors, :city, :string
    remove_column :donors, :state, :string
    remove_column :donors, :country, :string
    remove_column :donors, :ssn_id, :string
    remove_column :donors, :email, :string
    remove_column :donors, :user_id, :integer
    remove_column :donors, :center_id, :integer
    remove_column :donors, :address_line_1, :string
    add_column :donors, :alternate_email, :string
  end
end
