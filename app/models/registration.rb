class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  delegate :email, to: :user, prefix: true
  alias_method :cancel, :destroy

end
