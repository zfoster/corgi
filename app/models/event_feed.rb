class EventFeed < ActiveRecord::Base
  def sync
    Event.import_from_ical_url(url)
    touch(:synced_at)
  end
end
