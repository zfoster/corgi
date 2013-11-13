class AddEventFeedIdToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :event_feed_id, index: true
  end
end
