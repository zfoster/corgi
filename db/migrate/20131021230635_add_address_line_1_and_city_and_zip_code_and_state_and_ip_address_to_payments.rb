class AddAddressLine1AndCityAndZipCodeAndStateAndIpAddressToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :ip_address, :string
    add_column :payments, :address_line_1, :string
    add_column :payments, :address_line_2, :string
    add_column :payments, :city, :string
    add_column :payments, :state, :string
    add_column :payments, :zip_code, :string
  end
end
