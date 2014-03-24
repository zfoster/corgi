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
    parse_date_fields
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

  def parse_date_fields
    start_time = params[:event][:start_time].to_date
    end_time = params[:event][:end_time].to_date
    params[:event]['start_time(1i)'],
      params[:event]['start_time(2i)'],
      params[:event]['start_time(3i)'],
      params[:event]['end_time(1i)'],
      params[:event]['end_time(2i)'],
      params[:event]['end_time(3i)'] = nil
    unless start_time == nil
      params[:event]['start_time(1i)'] = start_time.year.to_s
      params[:event]['start_time(2i)'] = start_time.month.to_s
      params[:event]['start_time(3i)'] = start_time.day.to_s
    end
    unless end_time == nil
      params[:event]['end_time(1i)'] = end_time.year.to_s
      params[:event]['end_time(2i)'] = end_time.month.to_s
      params[:event]['end_time(3i)'] = end_time.day.to_s
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
    parse_date_fields
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
      :start_time, :end_time, :url, :organization_name, :address_line_1, :lat, :lon, :state
  end
end
