class Event::Importer
  include HTTParty

  def initialize(url)
    @url = url
  end

  def import
    @event = Event.where(source: source, source_id: source_id).first_or_initialize
    @event.attributes = attributes
    @event
  end

end
