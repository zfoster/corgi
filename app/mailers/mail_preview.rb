class MailPreview < MailView

  def event_created
    event = Event.create!
    user = event.owner
    mail = Notifier.welcome(event, user)
    user.destroy
    event.destroy
    mail
  end

  def attendees_updated
    event = Event.create!
    user = event.owner
    mail = Notifier.welcome(event, user)
    user.destroy
    event.destroy
    mail
  end

end