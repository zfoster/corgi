class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_or_create_with_omniauth(auth)
    identity = self.where(provider: auth['provider'], uid: auth['uid']).first_or_create
    identity.update_attributes auth_response: auth.to_hash
    identity
  end

  def find_or_create_user
    unless user
      build_user_from_auth
      save
    end
    user
  end

  private

  def build_user_from_auth
    new_user = User.create email: auth_response['info']['email'], 
      first_name: auth_response['info']['first_name'],
      last_name: auth_response['info']['last_name']
    self.user = new_user
  end

end
