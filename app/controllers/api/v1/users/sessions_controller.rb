# frozen_string_literal: true

# This class represents the SessionsController for API version 1

module Api
  module V1
    module Users
      # Controller for user sessions.
      class SessionsController < Devise::SessionsController
        respond_to :json
        require 'dotenv/load'
        def request_new_password
          user = User.find_by(email: params[:email])
          if user
            reset_token = user.send_reset_password_instructions
            render json: { success: true, message: 'Password reset instructions sent to your email.' , reset_token: reset_token}, status: :ok
          else
            render json: { success: false, error: 'User not found.' }, status: :not_found
          end
        end

        def set_new_password
          user = User.with_reset_password_token(params[:token])
          if user
            if user.reset_password(params[:password], params[:password_confirmation])
              render json: { success: true, message: 'Password has been reset successfully.' }, status: :ok
            else
              render json: { success: false, errors: user.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { success: false, error: 'Invalid or expired password reset token.' }, status: :not_found
          end
        end

        private

        def respond_with(current_user, _opts = {})
          render json: {
            status: {
              code: 200, message: 'Logged in successfully.',
              data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
            }
          }, status: :ok
        end

        # rubocop:disable Metrics/MethodLength
        def respond_to_on_destroy
          if request.headers['Authorization'].present?
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
                                     ENV['DEVISE_JWT_SECRET_KEY']).first
            current_user = User.find(jwt_payload['sub'])
          end

          if current_user
            render json: {
              status: 200,
              message: 'Logged out successfully.'
            }, status: :ok
          else
            render json: {
              status: 401,
              message: "Couldn't find an active session."
            }, status: :unauthorized
          end
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
