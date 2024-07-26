# frozen_string_literal: true

# The model representing a user in the system.
class User < ApplicationRecord
  mount_uploader :photo, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  belongs_to :profileable, polymorphic: true, optional: true

  validates :ssn_id, uniqueness: true

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self
  enum role: { donor: 0, admin: 1, hr: 2, operator: 3 }

  def valid_otp?(otp)
    otp == otp
  end
end
