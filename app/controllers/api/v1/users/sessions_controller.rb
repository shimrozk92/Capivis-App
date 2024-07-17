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
            otp = generate_otp
            send_otp_to_user(otp, user)
            user.update(otp: otp)
            render json: { success: true, message: 'Password reset instructions sent to your email.', otp: otp }, status: :ok
          else
            render json: { success: false, error: 'User not found.' }, status: :not_found
          end
        end

        def set_new_password
          user = User.find_by(email: params[:email])
          if user
            if user.reset_password(params[:password], params[:password_confirmation])
              render json: { success: true, message: 'Password has been reset successfully.' }, status: :ok
            else
              render json: { success: false, errors: user.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { success: false, error: 'User not found or invalid otp.' }, status: :not_found
          end
        end

        private

        def generate_otp
          SecureRandom.random_number(1000..9999).to_s.rjust(4, '0')
        end

        def send_otp_to_user(otp, user)
          puts "Generated OTP for #{user.email}: #{otp}"
          # Don't render here, just output to console
        end

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
          jwt_secret_key = ENV['DEVISE_JWT_SECRET_KEY']
          if request.headers['Authorization'].present?
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,ENV['DEVISE_JWT_SECRET_KEY']).first
            current_user = User.find(jwt_payload['sub'])
          end

          if current_user
            render json: { status: 200, message: 'Logged out successfully.' }, status: :ok
          else
            render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
          end
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
