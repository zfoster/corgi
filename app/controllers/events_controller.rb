class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :new_attendee]

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.created_events.new(event_params)
    @event.hosts << current_user
    @event.attendees << current_user
    if @event.save
      EventMailer.created(@event).deliver
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @event.attributes(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :address_line_1, :address_line_2, :city, :state, :zip_code)
  end
end
