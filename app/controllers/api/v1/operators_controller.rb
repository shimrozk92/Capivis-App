class Api::V1::OperatorsController < ApplicationController

	def donors_list
		if current_user.operator == current_user.id
			@donors = Donor.all
			render json: @donors
		else
			puts "you are not authorize to do"
		end
	end
end
