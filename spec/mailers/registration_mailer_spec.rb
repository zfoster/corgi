require 'spec_helper'

describe RegistrationMailer do
  describe ".created" do
    let(:registration) { create(:registration) }

    subject { RegistrationMailer.created(registration) }

    it "should be set to be delivered to the attendee" do
      should deliver_to(registration.user_email)
    end

    it "should have a show link" do
      should have_body_text(/#{event_url(registration.event)}/)
    end

    it 'should have a cancel registration link' do
      should have_body_text(/#{cancel_registration_event_path(registration.event)}/)
    end

  end
end
