class AddIcalUidToEvent < ActiveRecord::Migration
  def change
    add_column :events, :ical_uid, :string
  end
end
