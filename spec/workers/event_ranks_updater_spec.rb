require 'spec_helper'

describe EventRanksUpdater do

  describe "#perform" do
    before do
      2.times { User.create }
    end

    it 'should queue a rank update job' do
      event_id = 1
      RankUpdater.should_receive('perform_async').twice
      EventRanksUpdater.new.perform(event_id)
    end

  end
end
