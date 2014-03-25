require 'spec_helper'

describe 'an attendee cancels their registration to an event' do

  let!(:event) { create(:event) }

  describe 'attendee cancels registration' do
    it 'clicks cancel' do
      visit root_path
      click_link 'Connect with Facebook'
      click_on 'Events'
      # first('.attend a').click
      # first('.attending a').click
      # page.should have_content('Your registration has been canceled')
    end
  end
end
