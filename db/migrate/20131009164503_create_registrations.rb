class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :attendee_id
      t.integer :event_id

      t.timestamps
    end
  end
end
