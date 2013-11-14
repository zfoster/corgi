class FollowUpdater < BaseWorker

  def perform(identity_id)
    identity = Identity.find(identity_id)
    identity.update_follows
    identity.link_existing_follows
  end
end