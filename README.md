# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/users/sessions', type: :request do
  path '/login' do
    get('new session') do
      response(200, 'successful') do
        after do |example|
          begin
            if response.present?
              example.metadata[:response][:content] = {
                'application/json' => {
                  example: JSON.parse(response.body, symbolize_names: true)
                }
              }
            end
          rescue JSON::ParserError => e
            puts "JSON parsing error: #{e.message}"
          end
        end
        run_test!
      end
    end

    post('create session') do
      response(200, 'successful') do
        after do |example|
          begin
            if response.present?
              example.metadata[:response][:content] = {
                'application/json' => {
                  example: JSON.parse(response.body, symbolize_names: true)
                }
              }
            end
          rescue JSON::ParserError => e
            puts "JSON parsing error: #{e.message}"
          end
        end
        run_test!
      end
    end
  end

  path '/logout' do
    delete('delete session') do
      response(200, 'successful') do
        after do |example|
          begin
            if response.present?
              example.metadata[:response][:content] = {
                'application/json' => {
                  example: JSON.parse(response.body, symbolize_names: true)
                }
              }
            end
          rescue JSON::ParserError => e
            puts "JSON parsing error: #{e.message}"
          end
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/request_new_password' do
    post('request_new_password session') do
      response(200, 'successful') do
        after do |example|
          begin
            if response.present?
              example.metadata[:response][:content] = {
                'application/json' => {
                  example: JSON.parse(response.body, symbolize_names: true)
                }
              }
            end
          rescue JSON::ParserError => e
            puts "JSON parsing error: #{e.message}"
          end
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/set_new_password' do
    post('set_new_password session') do
      response(200, 'successful') do
        after do |example|
          begin
            if response.present?
              example.metadata[:response][:content] = {
                'application/json' => {
                  example: JSON.parse(response.body, symbolize_names: true)
                }
              }
            end
          rescue JSON::ParserError => e
            puts "JSON parsing error: #{e.message}"
          end
        end
        run_test!
      end
    end
  end
end
