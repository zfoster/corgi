require 'csv'
class RegistrationsController < ApplicationController
  before_filter :set_registration, only: [:destroy]
  before_filter :set_event, only: [:index]

  def create
    if current_user
      @registration = current_user.registrations.new registration_params
      if @registration.event.price > 0
        if @registration.save
          redirect_to new_payment_path(registration_id: @registration.id)
        else
          redirect_to @registration.event, notice: 'There was an issue registering'
        end
      else
        if @registration.save
          RegistrationMailer.created(@registration).deliver
          redirect_to :back, notice: 'Sweet! You are attending this event'
        else
          redirect_to @registration.event, notice: 'There was an issue registering you for this event'
        end
      end
    else
      redirect_to identities_path, notice: 'You must authorize before continuing'
      session[:pre_authorization_page] = request.env['HTTP_REFERER']
    end
  end

  def destroy
    @registration.cancel
    redirect_to event_path(@registration.event), notice: 'Successfully removed you from this event.'
  end

  def index
    respond_to do |format|
      format.html
      format.csv { render csv: @event.registrations }
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_registration
    @registration = current_user.registrations.find(params[:id])
  end

  def registration_params
    params.permit(:event_id)
  end

end