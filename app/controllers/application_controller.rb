class ApplicationController < ActionController::Base
  include Authentication
  before_action :require_authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :user_signed_in?

  private

  def user_signed_in?
    # Replace this with your actual logic to check if a user is logged in
    session[:user_id].present?
  end
end
