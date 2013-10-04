class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.text :message

      t.timestamps
    end
  end
end
