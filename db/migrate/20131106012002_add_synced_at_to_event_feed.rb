class AddSyncedAtToEventFeed < ActiveRecord::Migration
  def change
    add_column :event_feeds, :synced_at, :datetime
  end
end
