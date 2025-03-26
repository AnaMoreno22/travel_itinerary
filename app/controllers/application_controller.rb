class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # before_action :authenticate_user!
  allow_browser versions: :modern
  # helper_method :current_user, :user_signed_in?

  # def current_user
    # raise @current_user.inspect
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end


  # def logged_in?
  #   current_user
  # end

  # def authenticate_user
  #   redirect_to login_path unless current_user
  # end

end
