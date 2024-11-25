class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    # Render login form
  end

  def create
    user = User.authenticate_by(email_address: params[:email_address], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash[:alert] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    # Log out the user
    reset_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end
