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
  scope :starts_in_the_future, -> { where('start_at > ?', Time.now) }

  delegate :email, to: :creator, prefix: true
  delegate :name, to: :organization, prefix: true, allow_nil: true

  attr_accessor :existing_url

  def self.create_from_url(url)
    parsed_url = URI.parse(url)
    case parsed_url.host
    when /eventbrite/
      create_from_eventbrite(url)
    when /meetup/
      create_from_meetup(url)
    end
  end

  def self.create_from_meetup(url)
    id = url.match(/\/events\/([0-9]+)/)[1]
    event = where(source: 'meetup', source_id: id).first_or_initialize
    unless event.persisted?
      data = Meetup.event(id)
      event.start_time = Time.at(data['time']/1000)
      event.end_time = Time.at(event.start_time + (data['duration']/1000).seconds)
      event.title = data['name']
      event.description = Nokogiri::HTML(data['description']).text
      event.organization = Organization.where(name: data['group']['name']).first_or_initialize
      event.address = data['venue']['address_1']
      event.save 
    end
    event
  end

  def self.create_from_eventbrite(url)
    id = Eventbrite.scrape_id(url)
    event = where(source: 'eventbrite', source_id: id).first_or_initialize
    unless event.persisted?
      data = Eventbrite.event_get(id)['event']
      event.start_time = data['start_date']
      event.end_time = data['end_date']
      event.title = data['title']
      event.description = Nokogiri::HTML(data['description']).text
      event.organization = Organization.where(name: data['organizer']['name']).first_or_initialize
      event.address = data['venue']['address']
      event.save 
    end
    event
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

end