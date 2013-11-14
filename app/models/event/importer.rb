class Event::Importer
  include HTTParty
  
  def initialize(url)
    @url = url
  end

end