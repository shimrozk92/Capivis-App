module Api
  module V1
    class CentersController < ApplicationController
      load_and_authorize_resource

      def index
        @centers = Center.all
        render json: @centers
      end
    end
  end
end
