class RegistrationsController < ApplicationController
  before_filter :set_registration, only: [:destroy]

  def create
    @registration = Registration.new registration_params
    if @registration.save
      RegistrationMailer.created(self).deliver
      redirect_to @registration.event, notice: 'Sweet! You are attending this event'
    else
      redirect_to @registration.event, notice: 'There was an issue registering'
    end
  end

  def destroy
    @registration.cancel
    redirect_to event_path(@registration.event), notice: 'Successfully removed you from this event.'
  end

  private

    def set_registration
      @registration = current_user.registrations.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:event_id, :user_id)
    end
end