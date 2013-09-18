class Identity < ActiveRecord::Base
  belongs_to :user

  def self.find_or_create_with_omniauth(auth)
    identity = self.where(provider: auth['provider'], uid: auth['uid']).first_or_create
    identity.update_attributes auth_response: auth.to_hash
    identity
  end

  def find_or_create_user
    unless user
      self.user = User.create \
        email: auth_response['info']['email'], 
        first_name: auth_response['info']['first_name'],
        last_name: auth_response['info']['last_name']
      save
    end
    user
  end

end
