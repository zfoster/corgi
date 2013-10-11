class CreateHostings < ActiveRecord::Migration
  def change
    create_table :hostings do |t|
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
