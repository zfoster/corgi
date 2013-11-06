class CreateEventFeeds < ActiveRecord::Migration
  def change
    create_table :event_feeds do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
