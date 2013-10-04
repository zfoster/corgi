class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.integer :capacity
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :uri
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
