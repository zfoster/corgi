require 'csv'
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :cancel_registration, :attendees_csv]

  def show
  end

  def index
    @events = Event.all
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

  def cancel_registration
    current_user.registrations.where(event_id: @event.id).destroy_all
    flash[:notice] = "Your registration has been canceled"
    redirect_to :back
  end

  def attendees_csv
    csv = @event.attendees_csv
    respond_to do |format|
      format.html
      format.csv { render csv: csv, filename: 'attendee_list' }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :price, :start_time, :end_time, :address_line_1, :address_line_2, :city, :state, :zip_code)
  end
end
