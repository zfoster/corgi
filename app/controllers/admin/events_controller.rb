class Admin::EventsController < AdminController
  def index
    if %w( future past this_week this_month).include?(params[:scope])
      @events = Event.send(params[:scope])
    else
      @events = Event.future
    end
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.created_events.new(event_params)
    @event.end_time_date = @event.start_time_date if @event.start_time_date
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.attributes = event_params
    if @event.save
      flash[:notice] = 'Event was successfully updated'
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = 'Event has been destroyed'
    redirect_to action: 'index'
  end

  def event_params
    params.require(:event).permit :title, :description, :price,
      :start_time, :end_time, :url, :organization_name, :existing_url,
      :lat, :lon, :address_line_1
  end

end
