# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'swagger_helper'

RSpec.describe '/api/v1/users/sessions', type: :request do
  let(:user_params) do
    {
      user: {
        token: 'example',
        password: 'password'
      }
    }
  end

  path '/api/v1/users/login' do
    post('create session') do
      tags 'LOGIN'
      consumes 'application/json'

      parameter name: :user, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'admin007@gmail.com' },
              password: { type: :string, example: 'password' }
            }
          }
        },
        required: %w[email password]
      }

      let(:user) { user_params } # Define the user parameter

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/logout' do
    delete('delete session') do
      parameter name: 'Authorization', in: :header, type: :string, required: true,
                description: 'Bearer token received upon successful login'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/request_new_password' do
    post('request_new_password session') do
      tags 'PASSWORD'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :email, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'admin007@gmail.com' }
        },
        required: %w[email]
      }

      response(200, 'successful') do
        run_test!
      end
    end
  end

  path '/api/v1/users/set_new_password' do
    post('set_new_password session') do
      tags 'PASSWORD'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :new_password_params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'admin007@gmail.com' },
          token: { type: :string, example: 'ioJN8HVRAR8VELqfP6aC' },
          password: { type: :string, example: 'new_password' },
          password_confirmation: { type: :string, example: 'new_password' }
        },
        required: %w[email token password password_confirmation]
      }

      response(200, 'successful') do
        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
