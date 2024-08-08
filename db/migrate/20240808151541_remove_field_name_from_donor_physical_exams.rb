class RemoveFieldNameFromDonorPhysicalExams < ActiveRecord::Migration[7.1]
  def change
    remove_column :high_risk_education_quizzes, :comments, :string
  end
end
