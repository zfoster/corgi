class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @identities = @user.identities
  end
end
