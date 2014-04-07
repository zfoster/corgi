class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_one :payment

  delegate :email, to: :user, prefix: true

  delegate :update_ranks, to: :event
  after_commit :update_ranks

  comma do
    user :name
    user_email :email
    created_at :registered_at
  end

end
