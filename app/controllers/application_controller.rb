class ApplicationController < ActionController::Base
  include Authentication
  before_action :require_authentication
  allow_browser versions: :modern

  helper_method :current_user, :user_signed_in?

  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end
end
