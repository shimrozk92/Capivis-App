class DonorQuestionnaireForm < ApplicationRecord
	has_many :questionnaire_form_fields, dependent: :destroy
	has_many :donor_questionnaires, dependent: :destroy
	belongs_to :center
end
