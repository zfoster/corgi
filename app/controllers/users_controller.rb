class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def twitter_email
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(email: params[:user][:email])
    redirect_to root_path
  end
end
