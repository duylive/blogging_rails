class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  def index
    @users = User.all
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User updated successfully."
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted successfully."
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:email, :username, :role)
  end

  def authorize_admin!
    redirect_to new_user_session_path, alert: "You must be an admin to access this page." unless current_user.admin?
  end
end
