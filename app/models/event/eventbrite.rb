class Event::Eventbrite < Event::Importer
  default_params app_key: ENV['EVENTBRITE_APP_KEY']

  def self.scrape_id(url)
    response = get(url)
    html = Nokogiri::HTML(response.body)
    url = html.css('a.contact_organizer_link').first['href']
    id = CGI.parse(URI.parse(url).query)['eid'].first
  end

  def source
    'eventbrite'
  end

  def event_data
    @response ||= self.class.get("https://www.eventbrite.com/json/event_get", query: { id: source_id })
  end

  def source_id
    @source_id ||= self.class.scrape_id(@url)
  end

  private

  def attributes
    { start_time: event_data['event']['start_date'],
      end_time: event_data['event']['end_date'],
      title: event_data['event']['title'],
      description: Nokogiri::HTML(event_data['event']['description']).text,
      organization_name: event_data['event']['organizer']['name'],
      address: event_data['event']['venue']['address'],
    }
  end

end