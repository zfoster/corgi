class AddVenueNameAndStreetAddressAndMetaLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :venue_name, :string
    add_column :events, :street_address, :string
    add_column :events, :meta_location, :json
  end
end
