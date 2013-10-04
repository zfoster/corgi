class AddEventIdAndUserIdToShares < ActiveRecord::Migration
  def change
    add_column :shares, :event_id, :integer
    add_column :shares, :user_id, :integer
  end
end
