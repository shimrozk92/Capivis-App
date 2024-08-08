class CreateGeneralAppearances < ActiveRecord::Migration[7.1]
  def change
    create_table :general_appearances do |t|
      t.references :donor_physical_exam, null: false, foreign_key: true
      t.boolean :result
      t.string :comments

      t.timestamps
    end
  end
end
