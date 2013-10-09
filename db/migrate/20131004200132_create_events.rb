class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day
      t.integer :venue_id
      t.datetime :corgi_create_date
      t.string :uri
      t.integer :num_of_seats


      t.timestamps
    end
    drop_table :social_objects
  end
end
