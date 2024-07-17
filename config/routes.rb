# config/routes.rb
Rails.application.routes.draw do
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

  devise_scope :user do
    namespace :api do
      namespace :v1 do
        get 'redirect_to_crm', to: 'crm_integration#redirect_to_crm'
        get 'home', to: 'home#index'
        namespace :users do
          post '/request_new_password', to: 'sessions#request_new_password'
          post '/set_new_password', to: 'sessions#set_new_password'
        end
      end
    end
  end

  get 'authenticate', to: 'authentication#authenticate'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :operators
      get 'donors_list', to: 'operators#donors_list'
      resources :donors do
        member do
          post :register
          post :accept
        end
      end
      resources :donor_physical_exams, only: [:index, :create, :show, :update, :destroy]
      resources :donor_handbooks
      resources :donor_questionnaire_forms do
        resources :questionnaire_form_fields, only: [:index, :show, :create, :update, :destroy]
      end
      resources :donor_questionnaires, only: [:index, :show, :create, :update, :destroy]
    end
  end
   resources :fraud_address_data
end
