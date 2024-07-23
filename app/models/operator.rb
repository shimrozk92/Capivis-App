class Operator < ApplicationRecord
  has_one :user, as: :profitable
  belongs_to :center
end