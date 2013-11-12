require 'spec_helper'

describe Event do

  describe "#organization_name=" do
  end

  describe "#update_ranks" do
    let(:event){ Event.new }

    it 'should queue a rank update job' do
      expect { event.update_ranks}.to change(EventRanksUpdater.jobs, :size).by(1)
    end

  end
end
