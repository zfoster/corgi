class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :new_attendee, :close_registration]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def new_attendee
    Registration.create(event_id: @event.id, user_id: current_user)
    redirect_to @event, notice: "Congrats! You're attending this event!"
  end

  def close_registration
    @event.update_attribute(:closed, true)
    redirect_to @event, notice: 'Registration closed.'
  end

  def attendee_csv
    csv = Event.to_csv
    respond_to do |format|
      format.csv { send_data csv }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:corgi_create_date, :title, :description, :uri, :num_of_seats, :start_time, :end_time, :venue_id, :all_day, :owner_id)
    end
end