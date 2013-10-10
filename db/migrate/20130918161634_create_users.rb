class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile_num
      t.string :avatar
      t.references :default_identity, index: true

      t.timestamps
    end
  end
end
