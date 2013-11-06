class AmpsController < ApplicationController
  before_filter :authorize_user!, only: [:create]
  before_filter :set_registration, only: [:destroy]
  before_filter :set_event, only: [:index]

  def create
    @amp = current_user.amps.new amp_params
    if @amp.save
      redirect_to events_path
    else
      redirect_to events_path, notice: 'There was an issue amplifying the event'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_amp
    @amp = current_user.amps.find(params[:id])
  end

  def amp_params
    params.permit(:event_id)
  end

end