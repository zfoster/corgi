class AddPulledEventsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pulled_events, :text
  end
end
