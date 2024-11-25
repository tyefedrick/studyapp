class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [ :promote_to_admin ]
  validates :email_address, presence: true, uniqueness: true

  def promote_to_admin
    user = User.find(params[:id])
    if user.update(role: :admin)
      redirect_to users_path, notice: "#{user.email} has been promoted to admin."
    else
      redirect_to users_path, alert: "Failed to promote #{user.email}."
    end
  end

  get "profile", to: "users#show", as: :profile

  def show
    @user = current_user
    # Render the profile view
  end

  private

  def authorize_admin
    redirect_to(root_path, alert: "Access denied.") unless current_user.admin?
  end
end
