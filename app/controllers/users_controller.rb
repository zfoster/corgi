class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @identities = @user.identities
    @emails = []
    @identities.each do |i|
      if i.info['email']
        @emails << i.info['email']
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(email: params[:user][:email])
    redirect_to @user
  end
end
