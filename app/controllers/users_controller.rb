class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end