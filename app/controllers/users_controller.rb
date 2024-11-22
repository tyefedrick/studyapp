class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [ :promote_to_admin ]

  def promote_to_admin
    user = User.find(params[:id])
    if user.update(role: :admin)
      redirect_to users_path, notice: "#{user.email} has been promoted to admin."
    else
      redirect_to users_path, alert: "Failed to promote #{user.email}."
    end
  end

  private

  def authorize_admin
    redirect_to(root_path, alert: "Access denied.") unless current_user.admin?
  end
end
