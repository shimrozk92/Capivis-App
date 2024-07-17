class AddFieldsToDonors < ActiveRecord::Migration[7.1]
  def change
    add_column :donors, :ethnicity, :string
    add_column :donors, :identification, :string
    add_column :donors, :finger_print, :string
    add_column :donors, :photo, :string
    add_column :donors, :ref_status, :boolean
    add_column :donors, :center_id, :integer
    add_column :donors, :user_id, :integer
    add_column :donors, :payment_card, :string
    add_column :donors, :status, :text
    add_column :donors, :ssn_id, :integer
  end
end
