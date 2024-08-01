class QuestionnaireFormFieldSerializer
  include JSONAPI::Serializer
  attributes :id, :donor_questionnaire_form_id, :field_type, :label
end
