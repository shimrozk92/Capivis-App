module Api
  module V1
    class DonorsController < ApplicationController
      before_action :set_donor, only: [:show, :update, :destroy, :register, :accept]
      load_and_authorize_resource

      def index
        @donors = Donor.includes(:user).all

        render json: @donors.as_json(include: { user: { only: [:first_name, :last_name, :ssn_id, :role, :phone_number, :city, :state, :country, :address_line_1, :photo, :birthdate] } })
      end

      def show
        render json: @donor.attributes.merge(user_fields), status: :ok
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
            DonorMailer.registration_confirmation(@donor).deliver_now
            render json: @donor.attributes.merge(user_fields), status: :ok
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
        params.require(:donor).permit(:middle_name, :gender, :zipcode, :alternate_phone_number, :address_line_1, :address_line_2, :document, :arrival_datetime, :potential_fraud, :ethnicity, :identification, :finger_print, :photo, :ref_status, :payment_card, :status, :ssn_id, :alternate_email, :language)
      end

      def user_fields
        current_user.slice(:first_name, :last_name, :ssn_id, :role, :phone_number, :city, :state, :country, :birthdate, :address_line_1, :photo)
      end
    end
  end
end
