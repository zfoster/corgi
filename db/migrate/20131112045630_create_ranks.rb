class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.references :event, index: true
      t.references :user, index: true
      t.integer :value

      t.timestamps
    end
  end
end
