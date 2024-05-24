# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do
  describe 'POST #request_new_password' do
    let(:user) { create(:user) }

    context 'with valid email' do
      it 'sends reset password instructions' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :request_new_password, params: { email: user.email }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('success' => true,
                                                     'message' => 'Password reset instructions sent to your email.')
      end
    end

    context 'with invalid email' do
      it 'returns not found error' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :request_new_password, params: { email: 'invalid@example.com' }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to include('success' => false, 'error' => 'User not found.')
      end
    end
  end

  describe 'PUT #set_new_password' do
    let(:user) { create(:user) }
    let(:token) { user.send_reset_password_instructions }

    context 'with valid token and password' do
      it 'resets password successfully' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        put :set_new_password, params: { token:, password: 'newpassword', password_confirmation: 'newpassword' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('success' => true,
                                                     'message' => 'Password has been reset successfully.')
      end
    end

    context 'with invalid or expired token' do
      it 'returns not found error' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        put :set_new_password,
            params: { token: 'invalidtoken', password: 'newpassword', password_confirmation: 'newpassword' }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to include('success' => false,
                                                     'error' => 'Invalid or expired password reset token.')
      end
    end

    context 'with password confirmation mismatch' do
      it 'returns unprocessable entity error' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        put :set_new_password, params: { token:, password: 'newpassword', password_confirmation: 'mismatch' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('success' => false)
        expect(JSON.parse(response.body)['errors']).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:token) { JWT.encode({ sub: user.id }, ENV['DEVISE_JWT_SECRET_KEY']) }

    context 'with valid authorization token' do
      before { request.headers['Authorization'] = "Bearer #{token}" }

      it 'logs out successfully' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        delete :destroy
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('status' => 200, 'message' => 'Logged out successfully.')
      end
    end

    context 'without authorization token' do
      it 'returns unauthorized error' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('status' => 401, 'message' => "Couldn't find an active session.")
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
