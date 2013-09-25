class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @hash = Digest::MD5.hexdigest(downcase_email)
  end


  def twitter_email
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(email: params[:user][:email])
    redirect_to @user

  def set_default_avatar

  end

  protected

  def downcase_email
    @user.email.downcase
  end
end
