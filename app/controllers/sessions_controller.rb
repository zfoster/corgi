class SessionsController < ApplicationController
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
    redirect_to @identity.user

    # if signed_in?
    #   if @identity.user == current_user
    #     redirect_to root_path, notice: "Already linked that account!"
    #   else
    #     @identity.user = current_user
    #     @identity.save
    #     redirect_to root_path, notice: "Successfully linked that account!"
    #   end
    # else
    #   if @identity.user.present?
    #     self.current_user = @identity.user
    #     redirect_to root_path, notice: "Signed in!"
    #   else
    #     @user = User.create email: auth['info']['email']
    #     @identity.user = @user
    #     @identity.save 
    #     redirect_to root_path, notice: "Please finish registering"
    #   end
    # end
  end

  def destroy
  end

end
