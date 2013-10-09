class MailPreview < MailView

  def event_created
    event = Struct.new(:title).new('My Awesome Event')
    EventMailer.event_created(event)
  end

  def attendees_updated
    event = Struct.new(:title).new('My Awesome Event')
    EventMailer.attendees_updated(event)
  end

  #other syntax options
  # Pull data from existing fixtures
  #   def invitation
  #     account = Account.first
  #     inviter, invitee = account.users[0, 2]
  #     Notifier.invitation(inviter, invitee) 
  #   end

  # # Factory-like pattern
  #   def welcome
  #     user = User.create!
  #     mail = Notifier.welcome(user)
  #     user.destroy
  #     mail
  #   end
end