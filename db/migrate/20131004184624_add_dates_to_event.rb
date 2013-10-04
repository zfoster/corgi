class AddDatesToEvent < ActiveRecord::Migration
  def change
    add_column :event, :start_date, :date
    add_column :event, :end_date, :date
    add_column :event, :start_time, :time
    add_column :event, :end_time, :time
    add_column :event, :all_day, :boolean
  end
end
