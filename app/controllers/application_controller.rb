class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :warning, :danger, :info
  config.time_zone = "Asia/Bangkok"
  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up){ |u| u.permit(:name, :email, :password, :password_confirmation)}
  end
  protect_from_forgery with: :exception

end

