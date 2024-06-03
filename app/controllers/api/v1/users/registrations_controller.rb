# frozen_string_literal: true

# This class represents the RegistrationsController for API version 1

module Api
  module V1
    module Users
      # Controller for user registrations.
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

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
      end
    end
  end
end
