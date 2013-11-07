class User < ActiveRecord::Base
  has_many :hostings
  has_many :amps

  has_many :follows, foreign_key: :follower_id
  has_many :complete_follows, -> { complete }, class_name: 'Follow', foreign_key: :follower_id
  has_many :followed_users, -> { distinct }, through: :complete_follows, source: :followee

  has_many :registrations
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id
  has_many :registered_events, -> { distinct }, through: :registrations, source: :event
  has_many :hosted_events, -> { distinct }, through: :hostings, source: :event
  has_many :amped_events, -> { distinct }, through: :amps, source: :event

  has_many :following_amps, through: :followed_users, source: :amps
  has_many :following_registrations, through: :followed_users, source: :amps
  has_many :following_hostings, through: :followed_users, source: :amps

  has_many :following_amped_events, through: :followed_users, source: :amped_events
  has_many :following_registered_events, through: :followed_users, source: :registered_events
  has_many :following_hosted_events, through: :followed_users, source: :hosted_events

  has_many :org_administrations
  has_many :administered_orgs, through: :org_administrations, source: :organization

  has_many :identities
  has_one :facebook_identity, -> { where provider: 'facebook' }, class_name: 'Identity'
  has_one :twitter_identity, -> { where provider: 'twitter' }, class_name: 'Identity'
  has_one :linkedin_identity, -> { where provider: 'linkedin' }, class_name: 'Identity'
  has_one :google_identity, -> { where provider: 'google' }, class_name: 'Identity'
  belongs_to :default_identity, class_name: 'Identity'

  before_update :update_madi_identity

  def update_madi_identity
    if default_identity_id_changed?
      self.avatar = default_identity.info['image']
      self.email = default_identity.info['email'] if default_identity.info['email']
    end
  end

  def registered?(event)
    registrations.exists? event_id: event.id
  end

  def amplified?(event)
    amps.exists? event_id: event.id
  end
end
