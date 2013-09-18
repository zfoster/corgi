class AddAuthResponseToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :auth_response, :hstore
  end
end
