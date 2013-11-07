class SessionsController < ApplicationController

  def new
  end

  def create
    auth = request.env['omniauth.auth']
    @identity = Identity.find_or_create_with_omniauth(auth)
    if signed_in?
      @identity.user = current_user
      @identity.save
    else
      @identity.find_or_create_user
      sign_in @identity.user
    end
    FollowUpdater.perform_async(@identity.id)
    unless @identity.user.email.present?
      redirect_to twitter_email_user_path(@identity.user.id) and return
    end
    redirect_to session[:pre_authorization_page] || root_path
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: 'Signed out!'
  end

end
