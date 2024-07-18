class ChangeResponsesToBeJsonInDonorQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    change_column :donor_questionnaires, :responses, :json, using: 'responses::json'
  end
end
