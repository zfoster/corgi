class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower, index: true
      t.references :followee, index: true
      t.string :source
      t.string :source_id

      t.timestamps
    end
  end
end
