class AddCardholderNameToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :cardholder_name, :string
    remove_column :payments, :first_name
    remove_column :payments, :last_name
  end
end
