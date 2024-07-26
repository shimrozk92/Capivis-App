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
            if resource.persisted?
              UserMailer.welcome_email(resource).deliver_later
              if params[:user][:profileable_type].present?
                create_profileable(resource)
              end
            end
          end
        end

        private

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :ssn_id, :role, :phone_number, :city, :state, :country, :birthdate, :address_line_1, :photo, :profileable_type])
        end

        def respond_with(current_user, _opts = {})
          if resource.persisted?
            render json: {
              status: { code: 200, message: 'Signed up successfully.' },
              data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
            }
          else
            render json: {
              status: { message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}" }
            }, status: :unprocessable_entity
          end
        end

        def create_profileable(user)
          profileable_type = params[:user][:profileable_type]
          profileable_params = params.require(:profileable).permit(:ref_status, :document) # Add any other necessary attributes here

          profileable_class = profileable_type.constantize
          profileable = profileable_class.new(profileable_params)
          if profileable.save
            user.profileable = profileable
            unless user.save
              render json: {
                status: { message: "User couldn't be updated with profileable. #{user.errors.full_messages.to_sentence}" }
              }, status: :unprocessable_entity
            end
          else
            user.errors.add(:base, profileable.errors.full_messages.to_sentence)
            render json: {
              status: { message: "Profileable couldn't be created successfully. #{profileable.errors.full_messages.to_sentence}" }
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
