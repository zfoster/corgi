class FollowUpdater < BaseWorker

  def perform(identity_id)
    identity = Identity.find(identity_id)
    identity.update_follows
  end
end