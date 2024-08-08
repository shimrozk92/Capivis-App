class ChangeBooleanToStringInDonorPhysicalExams < ActiveRecord::Migration[7.1]
  def change
    change_column :donor_physical_exams, :consent_for_plasmapheresis, :string
    change_column :donor_physical_exams, :donor_information_flip_chart, :string
  end
end
