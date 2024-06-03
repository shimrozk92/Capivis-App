# app/models/donor.rb
class Donor < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :birthdate, :gender, :zipcode, :phone_number, :city, :state, :country, :language, presence: true
  # Additional validations as needed
end
