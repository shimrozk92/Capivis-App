class AddAllFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :gender, :string
    add_column :users, :zipcode, :string
    add_column :users, :phone_number, :string
    add_column :users, :alternate_phone_number, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :language, :string
    add_column :users, :arrival_datetime, :datetime
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
  end
end
