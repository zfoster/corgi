class Amp < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  comma do
    user :first_name
    user :last_name
    user_email
    created_at
  end

end
