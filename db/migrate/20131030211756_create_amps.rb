class CreateAmps < ActiveRecord::Migration
  def change
    create_table :amps do |t|
      t.references :event, index: true
      t.references :user, index:true

      t.timestamps
    end
  end
end
