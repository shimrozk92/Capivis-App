class DonorQuestionnaireFormSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description

  has_many :questionnaire_form_fields
end
