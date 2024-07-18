class AddCenterToDonorQuestionnaireForms < ActiveRecord::Migration[7.1]
  def change
    add_reference :donor_questionnaire_forms, :center, foreign_key: true
  end
end
