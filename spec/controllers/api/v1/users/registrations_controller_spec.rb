# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'
RSpec.describe Api::V1::Users::RegistrationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          user: {
            email: 'admin007@example.com',
            password: 'password'
          }
        }
      end

      it 'creates a new user' do
        @request.env['devise.mapping'] = Devise.mappings[:user] # Add this line
        expect do
          post :create, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        @request.env['devise.mapping'] = Devise.mappings[:user] # Add this line
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          user: {
            email: '',
            password: ''
          }
        }
      end

      it 'does not create a new user' do
        @request.env['devise.mapping'] = Devise.mappings[:user] # Add this line
        expect do
          post :create, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'returns an unprocessable entity response' do
        @request.env['devise.mapping'] = Devise.mappings[:user] # Add this line
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
