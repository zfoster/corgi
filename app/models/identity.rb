require 'google/api_client'

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

  def update_follows
    followee_ids.map do |id|
      user.follows.create source: provider, source_id: id
    end
    touch(:follows_updated_at)
  end

  private

  def build_user_from_auth 
    new_user = User.create email: info['email'], name: name, avatar: info['image'], default_identity: self
    self.user = new_user
  end

  def api_client
    case provider
    when 'twitter'
      @api_client ||= Twitter::Client.new oauth_token: credentials['token'], oauth_token_secret: credentials['secret']
    when 'facebook'
      @api_client ||= Koala::Facebook::API.new(credentials['token'])
    when 'linkedin'
      @api_client ||= LinkedIn::Client.new ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
      @api_client.authorize_from_access credentials['token'], credentials['secret']
      @api_client 
    when 'google'
      @api_client ||= Google::APIClient.new application_name: 'Madi', application_version: '1.0.0'
      @api_client.authorization.access_token = credentials['token']
    end
    @api_client
  end

  def followee_ids
    case provider
    when 'twitter'
      api_client.friend_ids
    when 'facebook'
      api_client.get_connections("me", "friends", fields: ['id']).map { |friend| friend['id'] }
    when 'linkedin'
      api_client.connections(fields: ['id'])['all'].map(&:id).select{ |el| el != 'private' }
    when 'google'
      plus = api_client.discovered_api('plus', 'v1')
      JSON.parse(api_client.execute!(plus.people.list, userId: 'me', collection: 'visible', fields: 'items/id').body)['items'].map { |friend| friend['id'] }
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
