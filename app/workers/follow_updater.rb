class FollowUpdater
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(identity_id)
    identity = Identity.find(identity_id)
    identity.update_follows
  end
end