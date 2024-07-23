class Center < ApplicationRecord
  has_one :donor_screening, dependent: :destroy
  has_one :donor_questionnaire_form
  has_many :donations
  has_many :operators
  has_one :donor_handbook
  has_one :manager
end
