# frozen_string_literal: true

Rails.application.routes.draw do
  get 'fraud_address_data/index'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: '', path_names: {
                                 sign_in: 'api/v1/users/login',
                                 sign_out: 'api/v1/users/logout',
                                 registration: 'api/v1/users/signup'
                               },
                     controllers: {
                       sessions: 'api/v1/users/sessions',
                       registrations: 'api/v1/users/registrations'
                     }

  # post '/api/v1/users/request_new_password', to: 'users#request_new_password'
  # post '/api/v1/users/set_new_password', to: 'users#set_new_password'
  devise_scope :user do
    namespace :api do
      namespace :v1 do
        get 'home', to: 'home#index'
        namespace :users do
          post '/request_new_password', to: 'sessions#request_new_password'
          post '/set_new_password', to: 'sessions#set_new_password'
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :donors
    end
  end
end
