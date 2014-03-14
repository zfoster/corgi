class EventsController < ApplicationController
  before_action :authorize_user!, only: [:new, :create, :edit, :update]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :cancel_registration]

  def show
    respond_to do |format|
      format.html
      format.ics { render text: @event.to_ical_event }
    end
  end

  def index
    @events = Event.all
    respond_to do |format|
      format.html
      format.ics { render text: EventList.new(@events).to_ical }
    end
  end

  def new
    @event = Event.new
    @organization = Organization.all
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

  def import
    parsed_url = URI.parse(params[:url])
    @event = case parsed_url.host
    when /eventbrite/
      Event::Eventbrite.new(parsed_url.to_s).import
    when /meetup/
      Event::Meetup.new(parsed_url.to_s).import
    end
    render json: @event
  end

  def update
    @event.attributes=(event_params)
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

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit :title, :description, :price,
      :start_time, :end_time, :url, :organization_name
  end
end
