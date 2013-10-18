class User < ActiveRecord::Base
  has_many :identities
  has_many :registrations
  has_many :hostings
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id
  has_many :registered_events, -> { distinct }, through: :registrations, source: :event
  has_many :hosted_events, -> { distinct }, through: :hostings, source: :event
  has_many :org_administrations
  has_many :administered_orgs, through: :org_administrations, source: :organization
  
  has_one :facebook_identity, -> { where provider: 'facebook' }, class_name: 'Identity'
  has_one :twitter_identity, -> { where provider: 'twitter' }, class_name: 'Identity'
  has_one :linkedin_identity, -> { where provider: 'linkedin' }, class_name: 'Identity'
  has_one :googleplus_identity, -> { where provider: 'google_oauth2' }, class_name: 'Identity'
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

  def display_name
    [first_name, last_name].join(" ") 
  end

end
