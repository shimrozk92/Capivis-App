class CreateConsentForPlasmaphereses < ActiveRecord::Migration[7.1]
  def change
    create_table :consent_for_plasmaphereses do |t|
      t.references :donor_physical_exam, null: false, foreign_key: true
      t.boolean :result

      t.timestamps
    end
  end
end
