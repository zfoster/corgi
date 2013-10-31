class EventsController < ApplicationController
  before_action :authorize_user!, only: [:new]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :cancel_registration]

  def show
  end

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @organization = Organization.all
  end

  def edit
  end

  def create
    if event_params['existing_url'].present?
      @event = Event.create_from_url(event_params['existing_url'])
      redirect_to @event
    else
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
      :start_time, :end_time, :address_line_1, 
      :address_line_2, :city, :state, :zip_code, :url, 
      :organization_id, :existing_url
  end
end
