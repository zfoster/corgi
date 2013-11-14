class Event::Importer
  include HTTParty
  
  def initialize(url)
    @url = url
  end

  def import
    @event = Event.where(source: source, source_id: source_id).first_or_initialize
    unless @event.persisted?
      @event.update_attributes(attributes)
    end
    @event
  end

end