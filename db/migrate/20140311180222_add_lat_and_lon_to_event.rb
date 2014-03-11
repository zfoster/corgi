class AddLatAndLonToEvent < ActiveRecord::Migration
  def change
    add_column :events, :lat, :float
    add_column :events, :lon, :float
  end
end
