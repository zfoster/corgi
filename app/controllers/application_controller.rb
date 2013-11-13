class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end
  helper_method :current_user, :signed_in?

  def sign_in(user)
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def authorize_user!
    unless current_user
      session[:pre_authorization_page] = request.env['HTTP_REFERER']
      redirect_to identities_path, notice: 'You must authorize before continuing'
    end
  end

  def authorize_admin!
    redirect_to root_path, notice: 'You are not allowed to access that page' unless current_user.admin?
  end

end
