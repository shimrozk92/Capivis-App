class CreateDonorPhysicalExams < ActiveRecord::Migration[7.1]
  def change
    create_table :donor_physical_exams do |t|
      t.references :donor, null: false, foreign_key: true
      t.boolean :consent_for_plasmapheresis
      t.boolean :donor_information_flip_chart
      t.string :donor_consent_3rd_party_observer
      t.string :body_map_tattoos_piercings
      t.string :high_risk_education_quiz
      t.boolean :chaperone_required
      t.boolean :health_info_disclosed
      t.string :general_appearance
      t.string :heent
      t.string :cardiovascular
      t.string :lungs_chest
      t.string :abdomen
      t.string :musculoskeletal
      t.string :extremities
      t.string :lymphatic
      t.string :neurological
      t.string :mental_status

      t.timestamps
    end
  end
end
