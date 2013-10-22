class IdentitiesController < ApplicationController
  def destroy
    if current_user.identities.count > 1
      identity = current_user.identities.find(params[:id])
      identity.destroy
      flash[:notice] = "We have deleted your #{identity.provider.capitalize} connection"
    else
      flash[:notice] = 'You cannot disconnect if you are only connected to one social account'
    end
    redirect_to root_path
  end

  def index
  end
end
