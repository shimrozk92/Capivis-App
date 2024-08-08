class CreateBodyMapTattooPiercings < ActiveRecord::Migration[7.1]
  def change
    create_table :body_map_tattoo_piercings do |t|
      t.references :donor_physical_exam, null: false, foreign_key: true
      t.boolean :result
      t.string :comments

      t.timestamps
    end
  end
end
