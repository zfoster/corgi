class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :registration, index: :true
      t.integer :amount_in_cents
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expires_on
      t.string :last_4

      t.timestamps
    end
  end
end
