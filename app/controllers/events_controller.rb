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
    if current_user
      @ranks = Rank.joins(:event).where(user_id: current_user.id ).order('ranks.value desc, events.start_time asc').merge(Event.future)
    else
      @events = Event.all
      flash[:notice] = "Welcome to Madi! Your seeing a list of all events currently in our system. <a href='#{root_path}'>Connect one of your social media accounts</a> to see events tailored only to you.".html_safe
    end
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
    @event.end_time_date = @event.start_time_date if @event.start_time_date
    if @event.save
      @event.hosts << current_user
      @event.attendees << current_user
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
    if @event
      render json: @event
    else
      render json: { error: 'No Event Data Found'}, status: 404
    end
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
      :start_time_date, :start_time_time, :end_time_date, :end_time_time, :url, :organization_name, :address_line_1, :lat, :lon, :state
  end
end
