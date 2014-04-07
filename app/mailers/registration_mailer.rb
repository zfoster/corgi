class RegistrationMailer < ActionMailer::Base

  def created(registration)
    @registration = registration
    @attendee = registration.user
    @event = registration.event

    mail to: @attendee.email, subject: "You're attending an event"
  end
end
