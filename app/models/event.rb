class Event < ActiveRecord::Base
  has_many :hostings
  has_many :registrations
  has_many :amps
  belongs_to :organization
  has_many :hosts, -> { distinct }, through: :hostings, source: :user
  has_many :attendees, -> { distinct }, through: :registrations, source: :user
  has_many :amplifiers, -> { distinct }, through: :amps, source: :user
  belongs_to :organization
  belongs_to :creator, class_name: "User"
  belongs_to :event

  validates_presence_of :end_time, :if => :start_time?

  scope :closed, -> { where(closed: true) }
  scope :open, -> { where(closed: false) }
  scope :future, -> { where('start_time > ?', Time.now) }
  scope :past, -> { where('start_time < ?', Time.now) }
  scope :this_week, -> { where(start_time: Time.now..7.days.from_now)}
  scope :this_month, -> { where(start_time: Time.now..1.month.from_now)}

  delegate :email, to: :creator, prefix: true
  delegate :name, to: :organization, prefix: true, allow_nil: true

  attr_accessor :existing_url

  def self.create_from_url(url)
    parsed_url = URI.parse(url)
    case parsed_url.host
    when /eventbrite/
      Eventbrite.new(url).import
    when /meetup/
      Meetup.new(url).import
    end
  end

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

  def display_date
    start_time.strftime("%a %b #{start_time.day.ordinalize}")
  end

  def display_time
    start_time.strftime("%a %b #{start_time.day.ordinalize}, %l:%M %p")
  end

end
