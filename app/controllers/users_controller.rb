class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def twitter_email
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :avatar)
  end 

end
