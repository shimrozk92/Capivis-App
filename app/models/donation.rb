class Donation < ApplicationRecord
	belongs_to :donor
	belongs_to :center, optional: true
	has_one :donation_cancellation
	
	validates :center, presence: true, unless: :skip_center_validation

	attr_accessor :skip_center_validation
end
