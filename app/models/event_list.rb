class EventList

  def initialize(events)
    @events = events
  end

  def to_ical
    cal = Icalendar::Calendar.new
    @events.each do |event|
      cal.add_event(event.to_ical_event)
    end
    cal.publish
    cal.to_ical
  end

end