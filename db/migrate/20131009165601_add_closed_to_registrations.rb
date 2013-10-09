class AddClosedToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :closed, :boolean
  end
end
