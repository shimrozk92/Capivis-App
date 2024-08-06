class Donor < ApplicationRecord
  has_one :user, as: :profileable
  has_many :donor_questionnaires, dependent: :destroy
  has_many :donor_physical_exams
  # belongs_to :center
  has_many :donor_screenings, dependent: :destroy
  has_many :donations
  has_many :donation_cancellation
  validates :ref_status, :document, presence: true
  validates :address_line_2, :photo, :gender, presence: true, on: :register
  validate :check_potential_fraud
  before_validation :check_for_fraudulent_address

  def store_fingerprint(fingerprint_data)
    self.finger_print = BCrypt::Password.create(fingerprint_data)
    save
  end

  def authenticate_fingerprint(fingerprint_data)
    return false unless finger_print
    BCrypt::Password.new(finger_print) == fingerprint_data
  end

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
