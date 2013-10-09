class EventMailer < ActionMailer::Base
  default from: "from@example.com"

  def event_created(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Thank you for creating an event!')
  end

  def attendees_updated(user)
    @user = user
    @url = ''
    mail(to: @user.email, subject: 'Update on your event')
end
