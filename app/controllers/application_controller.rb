class ApplicationController < ActionController::Base
  include Authentication
  before_action :require_authentication
  allow_browser versions: :modern

  helper_method :current_user, :user_signed_in?

  protect_from_forgery with: :exception

  private

  # Returns the currently logged-in user based on the session
  def current_user
    Rails.logger.info "Session user_id: #{session[:user_id]}"
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Checks if a user is signed in
  def user_signed_in?
    current_user.present?
  end

  # Ensures that the user is authenticated for actions requiring login
  def require_authentication
    unless user_signed_in?
      Rails.logger.info "Access denied: User not logged in"
      redirect_to new_session_path, alert: "You must be logged in to access this page."
    end
  end
end
