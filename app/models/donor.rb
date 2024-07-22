class Donor < ApplicationRecord
  has_one :user, as: :profileable
  has_many :donor_questionnaire
  has_many :donor_physical_exams
  # belongs_to :center
  has_many :donor_screenings, dependent: :destroy
  has_many :donations
  has_many :donation_cancellation

  validates :address_line_2, :photo, :gender, presence: true
  validate :check_potential_fraud
  before_validation :check_for_fraudulent_address

  private

  def check_potential_fraud
    if potential_fraud == 'high'
      errors.add(:potential_fraud, 'is too high')
    end
  end

  def check_for_fraudulent_address
    fraud_matches = FraudAddressData.search(zip_code: self.zipcode)

    if fraud_matches.exists?
    # Check if there is a fully matched address
    fully_matched = fraud_matches.find { |match| match.zip_code == self.zipcode }

      if fully_matched
        self.potential_fraud = "fully_matched"
      else
        self.potential_fraud = "partially_matched"
      end
    else
      self.potential_fraud = "not_in_fraud_database"
    end
  end
end
