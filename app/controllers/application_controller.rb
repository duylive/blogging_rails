class ApplicationController < ActionController::Base
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin])
  end
end
