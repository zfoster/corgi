class AddDateAndNewStartTimeAndNewEndTimeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :date, :date
    add_column :events, :new_start_time, :time
    add_column :events, :new_end_time, :time
  end
end
