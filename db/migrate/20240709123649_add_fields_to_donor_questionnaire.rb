class AddFieldsToDonorQuestionnaire < ActiveRecord::Migration[7.1]
  def change
    add_reference :donor_questionnaires, :donor_questionnaire_forms, foreign_key: true
    remove_column :donor_questionnaires, :questions, :json
  end
end
