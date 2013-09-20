class AddAuthCredentialsToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :credentials, :hstore
    rename_column :identities, :auth_response, :info
  end
end
