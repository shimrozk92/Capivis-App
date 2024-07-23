class AddScheduledAtToDonations < ActiveRecord::Migration[7.1]
  def change
    add_column :donations, :scheduled_at, :datetime
  end
end
