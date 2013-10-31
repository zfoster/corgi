class AddAddressAndSourceAndIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :address, :string
    add_column :events, :source, :string
    add_column :events, :source_id, :string
  end
end
