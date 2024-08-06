module Api
  module V1
    class DonorScreeningsController < ApplicationController
      before_action :set_donor, only: [:create, :index]
      before_action :set_donor_screening, only: [:show, :update, :destroy]
      load_and_authorize_resource

      def index
        @donor_screenings = @donor.donor_screenings
        render json: @donor_screenings
      end

      def show
        render json: @donor_screening
      end

      def create
        @donor_screening = @donor.donor_screenings.new(donor_screening_params)

        if valid_screening?(@donor_screening)
          @donor_screening.status = "accepted"
          if @donor_screening.save
            render json: @donor_screening, status: :created
          else
            render json: @donor_screening.errors, status: :unprocessable_entity
          end
        else
          handle_out_of_limits(@donor_screening)
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
        valid = true
        valid &= screening.acceptable_arm_check
        valid &= screening.donor_weight.to_f.between?(110, 400)
        valid &= screening.donor_temperature.to_f.between?(96.0, 99.5)
        valid &= screening.hematocrit.to_i.between?(38, 54)
        valid &= screening.total_protein.to_f.between?(6.0, 9.0)
        valid
      end

      def handle_out_of_limits(screening)
        if !screening.donor_weight.to_f.between?(110, 400)
          @donor_screening.status = "deferred"
          @donor_screening.save
          render json: { error: "Donor out of weight limits", status: @donor_screening.status }, status: :unprocessable_entity
        elsif !screening.donor_temperature.to_f.between?(96.0, 99.5)
          @donor_screening.status = "deferred"
          @donor_screening.save
          render json: { error: "Donor out of temperature limits", status: @donor_screening.status }, status: :unprocessable_entity
        elsif !screening.hematocrit.to_i.between?(38, 54)
          @donor_screening.status = "deferred"
          @donor_screening.save
          render json: { error: "Donor out of hematocrit limits", status: @donor_screening.status }, status: :unprocessable_entity
        elsif !screening.total_protein.to_f.between?(6.0, 9.0)
          @donor_screening.status = "deferred"
          @donor_screening.save
          render json: { error: "Donor out of total protein limits", status: @donor_screening.status }, status: :unprocessable_entity
        elsif !screening.donor_blood_pressure.to_i.between?(90, 180)
          @donor_screening.status = "requires_retake"
          @donor_screening.save
          render json: { warning: "Donor blood pressure requires retake", status: @donor_screening.status }, status: :accepted
        else
          @donor_screening.status = "out_of_limits"
          @donor_screening.save
          render json: { error: "Donor out of limits", status: @donor_screening.status }, status: :unprocessable_entity
        end
      end
    end
  end
end
