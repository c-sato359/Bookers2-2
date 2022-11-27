class ApplicationController < ActionController::Base
	
	before_action :configure_permitted_parameters, if: :devise_controller?
   protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)
     user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password]) #{ |u| u.permit(:username, :email, :password_confirmation, :remember_me)}
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password])# { |u| u.permit(:login, :username, :password)}
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password]) #{ |u| u.permit(:username, :email, :password, :password_confirmation, :current_password))
  end
end