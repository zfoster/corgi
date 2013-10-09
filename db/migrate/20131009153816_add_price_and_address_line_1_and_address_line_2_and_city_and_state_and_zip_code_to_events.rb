class AddPriceAndAddressLine1AndAddressLine2AndCityAndStateAndZipCodeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :price, :integer, default: 0
    add_column :events, :address_line_1, :string
    add_column :events, :address_line_2, :string
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :zip_code, :string
  end
end
