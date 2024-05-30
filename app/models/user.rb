# frozen_string_literal: true

# The model representing a user in the system.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self
  attr_accessor :first_name, :last_name, :middle_name, :birthdate, :gender, :zipcode,
                :phone_number, :alternate_phone_number, :city, :state, :country,
                :arrival_datetime, :address_line_1, :address_line_1, :language, :document

  validates :first_name, :last_name, :birthdate, :gender, presence: true
  validates :gender, inclusion: { in: %w[male female] }
  validates :phone_number, :address_line_1, :address_line_2, :zipcode, :city, :state, :country, :arrival_datetime, :language, presence: true

  enum role: { user: 0, admin: 1, hr: 2 }

  def reset_password_without_validation(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    save(validate: false) # Skip validations
  end


  def valid_otp?(otp)
    otp == otp
  end
end
