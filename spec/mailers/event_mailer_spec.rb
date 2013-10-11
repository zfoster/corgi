require 'spec_helper'

describe EventMailer do
  describe ".created" do
    let(:event) { build(:event) }

    subject { EventMailer.created(event) }

    it "should be set to be delivered to the creator" do
      should deliver_to(event.creator_email)
    end

  end
end