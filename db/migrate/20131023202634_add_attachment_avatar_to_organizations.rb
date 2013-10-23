class AddAttachmentAvatarToOrganizations < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :organizations, :avatar
  end
end
