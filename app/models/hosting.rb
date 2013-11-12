class Hosting < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  delegate :update_ranks, to: :event
  after_commit :update_ranks
end
