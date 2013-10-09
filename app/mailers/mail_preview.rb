class MailPreview < MailView

  def event_created
    event = Struct.new(:title).new('My Awesome Event')
    mail = EventMailer.event_created(event)
  end

  def attendees_updated
    event = Struct.new(:title).new('My Awesome Event')
    mail = EventMailer.attendees_updated(event)
  end
end