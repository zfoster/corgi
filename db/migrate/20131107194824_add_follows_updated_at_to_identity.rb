class AddFollowsUpdatedAtToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :follows_updated_at, :datetime
  end
end
