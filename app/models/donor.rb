# app/models/donor.rb
class Donor < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :birthdate, :gender, :zipcode, :phone_number, :city, :state, :country, :language, presence: true
  # Additional validations as needed
  before_validation :check_for_fraudulent_address

  private

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
