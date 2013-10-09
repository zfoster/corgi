class EventMailer < ActionMailer::Base
  default from: "madi@meetmadi.com"

  def event_created(event)
    @event = event
    @user = event.owner
    mail(to: @user.email, subject: 'Thank you for creating an event!')
  end

  def attendees_updated(event)
    @event = event
    @user = event.owner
    mail(to: @user.email, subject: 'Updates about your event')
end
