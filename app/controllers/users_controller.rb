class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def twitter_email
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :avatar, :mobile_num)
  end 

end
