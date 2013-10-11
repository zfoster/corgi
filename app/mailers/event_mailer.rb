class EventMailer < ActionMailer::Base
  default from: "from@example.com"

  def created(event)
    @event = event
    @creator = event.creator
    mail to: @creator.email, subject: 'You created an event'
  end
end
