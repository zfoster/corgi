class RegistrationsController < ApplicationController
  before_filter :authorize_user!, only: [:create]
  before_filter :set_registration, only: [:destroy]
  before_filter :set_event

  def new
    @registration = @event.registrations.new
  end

  def create
    @registration = current_user.registrations.new registration_params
    if !current_user.payment_token? && @registration.event.price.to_i > 0
      current_user.update_attribute(:payment_token, '123123123')
      session[:return_to] = request.env['HTTP_REFERER']
      redirect_to new_event_registration_path(@event)
    else
      if @registration.save
        RegistrationMailer.created(@registration).deliver
        redirect_to session.delete(:return_to) || :back, notice: 'Sweet! You are attending this event'
      else
        redirect_to session.delete(:return_to) || :back, notice: 'There was an issue registering you for this event'
      end
    end
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