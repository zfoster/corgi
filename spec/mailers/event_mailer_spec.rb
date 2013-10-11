require 'spec_helper'

describe EventMailer do
  describe ".created" do
    let(:event) { create(:event) }

    subject { EventMailer.created(event) }

    it "should be set to be delivered to the creator" do
      should deliver_to(event.creator_email)
    end

    it "should have an edit link" do
      should have_body_text(/#{edit_event_url(event)}/)
    end

  end
end