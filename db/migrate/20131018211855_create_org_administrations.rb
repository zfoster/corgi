class CreateOrgAdministrations < ActiveRecord::Migration
  def change
    create_table :org_administrations do |t|
      t.references :user, index: true
      t.references :organization, index: true

      t.timestamps
    end
  end
end
