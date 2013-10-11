class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  delegate :email, to: :user, prefix: true

  def cancel
    self.destroy
  end

end
