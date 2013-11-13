class EventFeed < ActiveRecord::Base
  has_many :events

  def sync
    calendars.each do |calendar|
      calendar.events.each do |ical_event|
        event = events.where(ical_uid: ical_event.uid).first_or_initialize
        event.attributes = attributes_from_ical(ical_event)
        event.save!
      end
    end
    touch(:synced_at)
  end

  def calendars
    @calendars ||= Icalendar::parse(response)
  end

  def response
    @response ||= HTTParty.get(url)
  end

  def attributes_from_ical(ical)
    { start_time: ical.start,
      end_time: ical.end, 
      address: ical.location,
      title: ical.summary,
      description: ical.description,
      url: ical.url.try(:to_s),
    }
  end

end
