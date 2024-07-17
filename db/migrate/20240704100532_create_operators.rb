class CreateOperators < ActiveRecord::Migration[7.1]
  def change
    create_table :operators do |t|
      t.integer :center_id
      t.string :designation
      t.string :image
      t.string :pin

      t.timestamps
    end
  end
end
