class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_one :payment

  delegate :email, to: :user, prefix: true

  comma do
    user :name
    user_email
    created_at
  end

end
