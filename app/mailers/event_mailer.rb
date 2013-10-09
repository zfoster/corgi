class EventMailer < ActionMailer::Base
  default from: "from@example.com"

  def event_created(event)
    @event = event
    @user = event.owner
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Thank you for creating an event!')
  end

  def attendees_updated(event)
    @event = event
    @user = event.owner
    @url = ''
    mail(to: @user.email, subject: 'Update on your event')
end
