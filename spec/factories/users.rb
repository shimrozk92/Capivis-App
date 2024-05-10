# frozen_string_literal: true

# spec/factories/user.rb

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' } # Change this to match your password requirements
    password_confirmation { 'password' } # Change this to match your password requirements
  end
end
