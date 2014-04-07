class EventMailer < ActionMailer::Base

  def created(event)
    @event = event
    @creator = event.creator
    mail to: @creator.email, subject: 'You created an event'
  end
end
