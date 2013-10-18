class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  delegate :email, to: :user, prefix: true

  comma do
    user :first_name
    user :last_name
    user_email
    created_at
  end

end
