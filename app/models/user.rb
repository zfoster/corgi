class User < ActiveRecord::Base
  has_many :registrations
  has_many :hostings
  has_many :amps
  has_many :ranks

  has_many :follows, foreign_key: :follower_id
  has_many :complete_follows, -> { complete }, class_name: 'Follow', foreign_key: :follower_id
  has_many :followed_users, -> { distinct }, through: :complete_follows, source: :followee

  has_many :followings, foreign_key: :followee_id, class_name: 'Follow'
  has_many :following_users, -> { distinct }, through: :followings, source: :followee

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

  after_create :set_first_and_last_name
  before_update :update_madi_identity
  after_create :update_ranks

  alias_attribute :FirstName, :first_name
  alias_attribute :LastName, :last_name
  alias_attribute :CompanyName, :company_name

  def update_madi_identity
    if default_identity_id_changed?
      self.avatar = default_identity.info['image']
      self.email = default_identity.info['email'] if default_identity.info['email']
    end
  end

  def following_user_ids
    followed_users.pluck(:id)
  end

  def registered?(event)
    registrations.exists? event_id: event.id
  end

  def amplified?(event)
    amps.exists? event_id: event.id
  end

  def update_ranks
    UserRanksUpdater.perform_async(self.id)
  end

  def set_first_and_last_name
    names = name.split(' ')
    update_attributes(first_name: names[0], last_name: names[1])
  end

  def following_events
    # Event.joins(:)
    # Event.find_by_sql(
    # 'SELECT events.*
    # FROM events
    # INNER JOIN registrations
    # ON events.id = registrations.event_id
    # INNER JOIN users
    # ON users.id = registrations.user_id
    # WHERE users.id IN (SELECT follower_id FROM follows WHERE followee_id IS NOT NULL)
    # GROUP BY events.id')

    # (SELECT(SELECT COUNT(id) FROM registrations WHERE registrations.event_id = events.id) * 2 +
    #   (SELECT COUNT(id) FROM hostings WHERE hostings.event_id = events.id) * 4 +
    #   (SELECT COUNT(id) FROM amps WHERE amps.event_id = events.id) * 1) AS event_weight
  end
end
