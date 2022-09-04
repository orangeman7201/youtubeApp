class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_account_update_parameters, if: :devise_controller?

  protected

  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:image, :name, :limit])
  end
end
