class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :uri
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :type

      t.timestamps
    end
  end
end
