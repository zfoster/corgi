class CreateSocialObjects < ActiveRecord::Migration
  def change
    create_table :social_objects do |t|
      t.integer :corgi_foreign_key
      t.datetime :corgi_create_date
      t.string :type
      t.string :title
      t.text :description
      t.string :uri

      t.timestamps
    end
  end
end
