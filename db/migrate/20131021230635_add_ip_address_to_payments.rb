class AddIpAddressToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :ip_address, :string
  end
end
