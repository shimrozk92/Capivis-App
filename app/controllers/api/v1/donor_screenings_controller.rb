module Api
  module V1
    class DonorScreeningsController < ApplicationController
      before_action :set_donor, only: [:create]
      before_action :set_donor_screening, only: [:show, :update, :destroy]
      load_and_authorize_resource

      def index
        @donor_screenings = DonorScreening.all
        render json: @donor_screenings
      end

      def show
        render json: @donor_screening
      end

      def create
        @donor_screening = @donor.donor_screening.new(donor_screening_params)

        if valid_screening?(@donor_screening)
          @donor_screening.status = "accepted"
          if @donor_screening.save
            render json: @donor_screening, status: :created
          else
            render json: @donor_screening.errors, status: :unprocessable_entity
          end
        else
          @donor_screening.status = "out_of_limits"
          if @donor_screening.save
            @donor.destroy
            render json: @donor_screening, status: :unprocessable_entity
          else
            render json: @donor_screening.errors, status: :unprocessable_entity
          end
        end
      end

      def update
        if @donor_screening.update(donor_screening_params)
          render json: @donor_screening
        else
          render json: @donor_screening.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @donor_screening.destroy
      end

      private

      def set_donor
        @donor = Donor.find(params[:donor_id])
      end

      def set_donor_screening
        @donor_screening = DonorScreening.find(params[:id])
      end

      def donor_screening_params
        params.require(:donor_screening).permit(
          :center_id, 
          :acceptable_arm_check, 
          :donor_height, 
          :donor_weight, 
          :donor_blood_pressure, 
          :donor_temperature, 
          :fingerstick_timestamp, 
          :hematocrit, 
          :total_protein,
          :status
        )
      end

      def valid_screening?(screening)
        screening.acceptable_arm_check &&
          screening.donor_weight.to_f.between?(110, 400) &&
          screening.donor_blood_pressure.to_i.between?(90, 180) &&
          screening.donor_temperature.to_f.between?(96.0, 99.5) &&
          screening.hematocrit.to_i.between?(38, 54) &&
          screening.total_protein.to_f.between?(6.0, 9.0)
      end
    end
  end
end
