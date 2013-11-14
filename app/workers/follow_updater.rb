class FollowUpdater < BaseWorker

  def perform(identity_id)
    identity = Identity.find(identity_id)
    identity.create_follows
    identity.complete_existing_follows
  end
end