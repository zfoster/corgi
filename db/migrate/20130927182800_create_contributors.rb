class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.string :email
      t.string :contribution

      t.timestamps
    end
  end
end
