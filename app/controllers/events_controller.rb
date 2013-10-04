class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :new_member]

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

  def new_member
    redirect_to new_share_path(id: @event.id)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:corgi_create_date, :title, :description, :uri, :num_of_seats, :start_time, :end_time, :venue_id, :all_day)
    end
end