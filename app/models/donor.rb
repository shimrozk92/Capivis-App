class Donor < ApplicationRecord
  has_many :donor_physical_exams
  belongs_to :user
  belongs_to :center
  has_many :donor_screening
  has_many :donations

  validates :email, :first_name, :last_name, :birthdate, :gender, :phone_number, :center_id, :user_id, presence: true, on: :create
  validates :ssn_id, :address_line_1, :identification, :finger_print, :photo, :payment_card, presence: true, on: :register
  validate :check_potential_fraud
  before_validation :check_for_fraudulent_address
  before_create :generate_unique_ssn

  private

  def check_potential_fraud
    if potential_fraud == 'high'
      errors.add(:potential_fraud, 'is too high')
    end
  end

  def generate_unique_ssn
    self.ssn_id = loop do
      random_ssn = Array.new(9) { rand(0..9) }.join
      break random_ssn unless Donor.exists?(ssn_id: random_ssn)
    end
  end

  def check_for_fraudulent_address
    fraud_matches = FraudAddressData.search(address: address_line_1, city: self.city, state: self.state, zip_code: self.zipcode)

    if fraud_matches.exists?
    # Check if there is a fully matched address
    fully_matched = fraud_matches.find { |match| match.address == address_line_1 && match.city == self.city && match.state == self.state && match.zip_code == self.zipcode }

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
