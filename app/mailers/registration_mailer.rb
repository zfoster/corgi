class RegistrationMailer < ActionMailer::Base
  default from: "from@example.com"

  def created(registration)
    @registration = registration
    @attendee = registration.user
    mail to: @attendee.email, subject: "You're attending an event"
  end
end
