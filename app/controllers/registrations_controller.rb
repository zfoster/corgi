class RegistrationsController < ApplicationController
  before_filter :set_registration, only: [:destroy]

  def create
    @registration = current_user.registrations.new registration_params
    if @registration.save
      RegistrationMailer.created(@registration).deliver
      redirect_to :back, notice: 'Sweet! You are attending this event'
    else
      redirect_to @registration.event, notice: 'There was an issue registering you for this event'
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
    params.permit(:event_id)
  end

end