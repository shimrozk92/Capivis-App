# frozen_string_literal: true

# The main application controller.
class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |_exception|
    render json: { error: 'Access denied' }, status: :forbidden
  end
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
end
