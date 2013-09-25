class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @identities = @user.identities
    email_identities = []
    @identities.each do |i|
      email_identities << i unless i.info['email'].nil?
    end
    @unique_email_identities = email_identities.uniq_by { |i| i.info['email']}
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(email: params[:user][:email])
    redirect_to @user
  end

  def set_email
    @user = User.find(params[:id])
    @user.update_attributes(email: params[:user][:email])
    render nothing: true
  end
end
