class CreateQuestionnaireFormFields < ActiveRecord::Migration[7.1]
  def change
    create_table :questionnaire_form_fields do |t|
      t.references :donor_questionnaire_form, null: false, foreign_key: true
      t.string :field_type
      t.string :label
      t.text :options
      t.boolean :required

      t.timestamps
    end
  end
end
