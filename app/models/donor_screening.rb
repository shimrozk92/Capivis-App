class DonorScreening < ApplicationRecord
  belongs_to :donor
  belongs_to :center

  validates :donor_id, presence: true
  validates :center_id, presence: true
end
