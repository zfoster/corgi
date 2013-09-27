class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.text :note
      t.string :email

      t.timestamps
    end
  end
end
