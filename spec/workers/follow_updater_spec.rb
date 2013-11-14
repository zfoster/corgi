require 'spec_helper'

describe FollowUpdater do


  describe "#perform" do
    let(:identity){ build(:identity) }


    it 'should queue a rank update job' do
      Identity.should_receive(:find).with(identity.id).and_return(identity)
      identity.should_receive(:update_follows)
      identity.should_receive(:link_existing_follows)
      FollowUpdater.new.perform(identity.id)
    end

  end
end