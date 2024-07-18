class CreateDonorQuestionnaireForms < ActiveRecord::Migration[7.1]
  def change
    create_table :donor_questionnaire_forms do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
