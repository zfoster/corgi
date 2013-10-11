class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  delegate :email, to: :user, prefix: true
  after_create :confirm_attendance

  def cancel
    self.destroy
  end

  def confirm_attendance
    RegistrationMailer.created(self).deliver
  end

end
