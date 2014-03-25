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
  scope :future, -> { where('start_time > ?', 1.month.from_now) }
  scope :past, -> { where('start_time < ?', Time.now) }
  scope :this_week, -> { where(start_time: Time.now..7.days.from_now)}
  scope :this_month, -> { where(start_time: 7.days.from_now..1.month.from_now)}

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

  def display_date
    display_date = date.strftime("%A, %B %e") if date
  end

  def display_start_time
    display_start_time = new_start_time.strftime(", %l:%M%P") if new_start_time
  end

  def display_end_time
    display_end_time = new_end_time.strftime(", %l:%M%P") if new_end_time
  end

end
