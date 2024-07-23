# frozen_string_literal: true

# This class represents the RegistrationsController for API version 1

module Api
  module V1
    module Users
      # Controller for user registrations.
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        before_action :configure_permitted_parameters, if: :devise_controller?

        def create
          super do |resource|
            if params[:user][:profileable_type].present?
              create_profileable(resource)
            end
          end
        end

        private

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :ssn_id, :role, :phone_number, :city, :country, :address_line_1, :profileable_type] )
        end

        # rubocop:disable Metrics/MethodLength
        def respond_with(current_user, _opts = {})
          if resource.persisted?
            render json: {
              status: { code: 200, message: 'Signed up successfully.' },
              data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
            }
          else
            render json: {
              status: {
                message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"
              }
            }, status: :unprocessable_entity
          end
        end
        # rubocop:enable Metrics/MethodLength

        def create_profileable(user)
          profileable_type = params[:user][:profileable_type]
          profileable_params = params.require(:profileable).permit(:address_line_2, :photo, :gender)

          profileable_class = profileable_type.constantize
          profileable = profileable_class.new(profileable_params)

          if profileable.save
            user.profileable = profileable
            user.save
          else
            user.errors.add(:base, profileable.errors.full_messages.to_sentence)
            render json: {
              status: {
                message: "Profileable couldn't be created successfully. #{profileable.errors.full_messages.to_sentence}"
              }
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
