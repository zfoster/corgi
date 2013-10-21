class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :payment, index: :true
      t.integer :amount_in_cents
      t.boolean :success
      t.string :authorization
      t.string :message

      t.timestamps
    end
  end
end
