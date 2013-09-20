class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_or_create_with_omniauth(auth)
    identity = self.where(provider: auth.provider, uid: auth.uid).first_or_create
    identity.update_attributes AuthExtractor.new(auth).extract
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
    new_user = User.create email: info['email'], 
      first_name: info['first_name'],
      last_name: info['last_name']
    self.user = new_user
  end

end
