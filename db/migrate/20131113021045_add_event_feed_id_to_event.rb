class AddEventFeedIdToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :event_feed, index: true
  end
end
