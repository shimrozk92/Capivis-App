# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.configure do |config|
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s
  config.openapi_root = "#{Rails.root}/swagger"

  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        securitySchemes: {
          BearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        }
      },
      security: [{
        BearerAuth: []
      }],
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        },
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'example.com'
            }
          }
        }
      ]
    }
  }
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end

# rubocop:enable Metrics/BlockLength
