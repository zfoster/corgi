class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @identities = @user.identities
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(email: params[:user][:email])
    redirect_to @user
  end
end
