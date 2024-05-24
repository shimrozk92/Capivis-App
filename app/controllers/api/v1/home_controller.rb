# frozen_string_literal: true

module Api
  module V1
    # Controller for handling home-related API endpoints
    class HomeController < ApplicationController
      before_action :authenticate_user!
      # authorize_resource
      def index
        authorize! :read, Api::V1::HomeController
        render json: 'authorized succesfully'
      end
    end
  end
end
