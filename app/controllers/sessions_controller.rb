class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    # Render login form
  end

  def destroy
    # Logic to log out the user
    reset_session
    redirect_to root_path
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      session[:user_id] = user.id
      Rails.logger.info "Session user_id set to: #{session[:user_id]}"
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    # Log out the user
    reset_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end
