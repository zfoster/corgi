class Event < ActiveRecord::Base
  extend TimeSplitter::Accessors
  split_accessor :start_time, :end_time, default: -> { DateTime.current }

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  has_many :hostings
  has_many :registrations
  has_many :amps
  belongs_to :organization
  has_many :hosts, -> { distinct }, through: :hostings, source: :user
  has_many :attendees, -> { distinct }, through: :registrations, source: :user
  has_many :amplifiers, -> { distinct }, through: :amps, source: :user
  has_many :ranks
  belongs_to :organization
  belongs_to :creator, class_name: "User"
  belongs_to :event

  validates_presence_of :start_time, :title

  scope :closed, -> { where(closed: true) }
  scope :open, -> { where(closed: false) }
  scope :future, -> { where('start_time > ?', 1.month.from_now) }
  scope :past, -> { where('start_time < ?', Time.now) }
  scope :this_week, -> { where(start_time: Time.now..7.days.from_now)}
  scope :this_month, -> { where(start_time: 7.days.from_now..1.month.from_now)}

  after_create :update_ranks

  delegate :email, to: :creator, prefix: true
  delegate :name, to: :organization, prefix: true, allow_nil: true

  def to_ical
    cal = Icalendar::Calendar.new
    cal.add_event(self.to_ical_event)
    cal.publish
    cal.to_ical
  end

  def to_ical_event
    event = Icalendar::Event.new
    event.start = start_time.utc.strftime('%Y%m%dT%H%M%SZ')
    event.end = end_time.utc.strftime('%Y%m%dT%H%M%SZ')
    event.summary = title
    event.description = description
    event
  end

  def organization_name=(name)
    self.organization = Organization.where(name: name).first_or_initialize
  end

  def update_ranks
    EventRanksUpdater.perform_async(self.id)
  end

  def display_address
    address_line_1.chomp(", WI, United States")
  end

  def display_date
    start_time.strftime("%A %B #{start_time.day.ordinalize}")
  end

  def display_time
    start_time.strftime("%A %B %e, %l:%M%P")
  end

  def start_time_year
    start_time.year
  end

  def slug_candidates
    [ :title, [:title, :start_time] ]
  end

end
