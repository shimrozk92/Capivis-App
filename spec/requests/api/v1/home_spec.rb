# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/home', type: :request do
  path '/api/v1/home' do
    get('list homes') do
      response(200, 'successful') do
        after do |example|
          if response.content_type == 'application/json'
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
        end
        run_test!
      end
    end
  end
end
