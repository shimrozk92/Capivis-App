class ChangeRefStatusInTableName < ActiveRecord::Migration[7.1]
  def change
    change_column :donors, :ref_status, :string
  end
end
