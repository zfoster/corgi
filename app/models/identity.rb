require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_or_create_with_omniauth(auth)
    identity = where(provider: auth.provider, uid: auth.uid).first_or_initialize
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

  def build_user_from_autho
    user_info = {email: info['email'],
      name: name,
      avatar: info['image'],
      default_identity: self}
    user_info.merge!(contacts)
    new_user = User.create user_info
    self.user = new_user
  end

  def contacts
    case self.provider
    when 'twitter'
      twitter_user = Twitter::Client.new oauth_token: credentials['token'],
        oauth_token_secret: credentials['secret']
      {contacts: "#{twitter_user.following}"}
    when 'facebook'
      facebook_user = Koala::Facebook::API.new(credentials['token'])
      {contacts: "#{facebook_user.get_connections("me", "friends")}", pulled_events: "#{facebook_user.get_connections("me", "events")}"}
    when 'linkedin'
      linkedin_user = LinkedIn::Client.new(ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'])
      linkedin_user.authorize_from_access(credentials['token'], credentials['secret'])
      {contacts: "#{linkedin_user.connections}"}
    when 'google_oauth2'
      google_user = Google::APIClient.new(
        :application_name => 'Madi',
        :application_version => '1.0.0')
      plus = google_user.discovered_api('plus', 'v1')
      google_user.authorization.access_token = credentials['token']
      response = google_user.execute!(plus.people.list,
        :userId => 'me',
        :collection => 'visible').body
      {contacts: "#{response}"}
    end
  end


  def name
    if info['first_name']
      [info['first_name'], info['last_name']].join(' ')
    else
      info['name']
    end
  end

end
