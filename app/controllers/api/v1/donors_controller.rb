# app/controllers/api/v1/donor/donors_controller.rb
module Api
	module V1
		class DonorsController < ApplicationController
			before_action :set_donor, only: [:show, :update, :destroy]

			def index
				@donors = Donor.all
				render json: @donors
			end

			def show
				render json: @donor
			end

			def create
				@donor = Donor.new(donor_params)
				if @donor.save
					response = { donor: @donor, potential_fraud: @donor.potential_fraud }
					render json: response, status: :created
				else
					render json: @donor.errors, status: :unprocessable_entity
				end
			end

			def update
				if @donor.update(donor_params)
					render json: @donor
				else
					render json: @donor.errors, status: :unprocessable_entity
				end
			end

			def destroy
				@donor.destroy
				render json: { message: "Donor deleted successfully" }, status: :ok
			end

			private

			def set_donor
				@donor = Donor.find(params[:id])
			end

			def donor_params
				params.require(:donor).permit(:email, :first_name, :last_name, :middle_name, :birthdate, :gender, :zipcode, :phone_number, :alternate_phone_number, :city, :state, :country, :language, :address_line_1, :address_line_2, :arrival_datetime, document: [])
			end
		end
	end
end
