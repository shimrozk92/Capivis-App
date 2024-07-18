class CreateDonorQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    create_table :donor_questionnaires do |t|
      t.references :donor, null: false, foreign_key: true
      t.references :donor_questionnaire_form, null: false, foreign_key: true
      t.json :responses

      t.timestamps
    end
  end
end
