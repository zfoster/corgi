class RegistrationsController < ApplicationController
  before_filter :authorize_user!, only: [:create]
  before_filter :set_registration, only: [:destroy]
  before_filter :set_event

  def new
    @registration = @event.registrations.new
  end

  def create
    @registration = current_user.registrations.new registration_params
    if @registration.save
      redirect_to session.delete(:return_to) || :back
    else
      redirect_to session.delete(:return_to) || :back, notice: 'There was an issue registering you for this event'
    end
  end

  def index
    respond_to do |format|
      format.html
      format.csv { render csv: @event.registrations.to_comma }
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
