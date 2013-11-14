require 'google/api_client'

class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  has_many :follows,-> { where(source: provider, source_id: uid) }, class_name: 'Follow'

  delegate :followee_ids, to: :api

  def self.find_or_create_with_omniauth(auth)
    identity = where(provider: auth.provider, uid: auth.uid).first_or_initialize
    identity.update_attributes Auth.new(auth).extract
    identity
  end

  def find_or_create_user
    unless user
      build_user_from_auth
      save
    end
    user
  end

  def create_follows
    followee_ids.map do |id|
      user.follows.where(source: provider, source_id: id.to_s).first_or_create
    end
    touch(:follows_updated_at)
  end

  def complete_existing_follows
    existing_follows.each do |follow|
      follow.update_attributes(followee_id: user_id)
    end
  end

  def existing_follows
    @existing_follows ||= Follow.incomplete.where(source: provider, source_id: uid.to_s)
  end

  private

  def api
    @api ||= "Identity::#{provider.titleize}".constantize.new(credentials)
  end

  def build_user_from_auth 
    new_user = User.create email: info['email'], name: name, avatar: info['image'], default_identity: self
    self.user = new_user
  end

  def name
    if info['first_name']
      [info['first_name'], info['last_name']].join(' ')
    else
      info['name']
    end
  end

end
