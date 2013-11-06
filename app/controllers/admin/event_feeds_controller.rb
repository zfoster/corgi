class Admin::EventFeedsController < AdminController
  def index
    @event_feeds = EventFeed.all
    @new_event_feed = EventFeed.new
  end

  def create
    @event_feed = EventFeed.create!(event_feed_params)
    @event_feed.sync
    redirect_to admin_event_feeds_path
  end

  def destroy
  end

  def sync
    @event_feed = EventFeed.find(params[:id])
    @event_feed.sync
    redirect_to admin_event_feeds_path 
  end

  private

  def event_feed_params
    params.require(:event_feed).permit(:name, :url)
  end
end
