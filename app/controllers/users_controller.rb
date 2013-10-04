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

  def update_user_data
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    render nothing: true
  end

  def set_madi_identity
    @identity = Identity.find(params[:identity_id])
    @user = @identity.user
    @user.update_attributes(avatar: @identity.info['image'])
    @user.update_attributes(email: @identity.info['email']) unless @identity.provider == 'twitter'
    render :partial => 'default_identity', :locals => {:user => @user}, :layout => false
  end

  private

  def user_params
    params.require(:user).permit(:email, :avatar, :mobile_num)
  end
end
