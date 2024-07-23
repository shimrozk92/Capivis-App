module Api
  module V1
    class DonorsController < ApplicationController
      before_action :set_donor, only: [:show, :update, :destroy, :register, :accept]
      load_and_authorize_resource

      def index
        @donors = Donor.all
        render json: @donors
      end

      def show
        render json: @donor
      end

      def create
        @donor = Donor.new(donor_params)
        if @donor.save(context: :create)
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

      def register
        @donor = current_user.profileable

        if @donor.update(register_params)
          if @donor.valid?(context: :register)
            render json: @donor, status: :ok
          else
            render json: @donor.errors, status: :unprocessable_entity
          end
        else
          render json: @donor.errors, status: :unprocessable_entity
        end
      end

      def accept
        @donor.accept!
        render json: { message: 'Donor accepted' }, status: :ok
      end

      private

      def set_donor
        @donor = Donor.find_by(id: params[:id])
        render json: { error: 'Donor not found' }, status: :not_found if @donor.nil?
      end

      def donor_params
        params.require(:donor).permit(:email, :first_name, :last_name, :birthdate, :gender, :phone_number, :city, :state, :country, :language, :center_id, :user_id)
      end

      def register_params
        params.require(:donor).permit(:middle_name,:gender, :zipcode, :alternate_phone_number, :address_line_1, :address_line_2, :document, :arrival_datetime, :potential_fraud, :ethnicity, :identification, :finger_print, :photo, :ref_status, :payment_card, :status, :ssn_id)
      end
    end
  end
end
