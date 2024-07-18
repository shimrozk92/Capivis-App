class DonorQuestionnaire < ApplicationRecord
  belongs_to :donor
  belongs_to :donor_questionnaire_form

  def question_answers
    form_fields = donor_questionnaire_form.questionnaire_form_fields
    responses = self.responses
    form_fields.map do |field|
      {
        question: field.label,
        answer: responses[field.id.to_s]
      }
    end
  end
end
