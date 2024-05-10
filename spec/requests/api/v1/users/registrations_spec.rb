# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'swagger_helper'

RSpec.describe 'api/v1/users/registrations', type: :request do
  let(:user_params) do
    {
      user: {
        email: 'test@gmail.com',
        password: 'password',
        name: 'test',
        role: '1'
      }
    }
  end
  path '/api/v1/users/signup' do
    post('create registration') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              name: { type: :string },
              role: { type: :integer }
            }
          }
        },
        required: %w[email password name role]
      }
      let(:user) { user_params }
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
end

# rubocop:enable Metrics/BlockLength
