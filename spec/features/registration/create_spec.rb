require 'spec_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline! do
  describe "An authenticated user registers to attend event" do

    # let!(:event) { create(:event) }
    # let!(:user) { create(:user) }
    # let!(:rank) { create(:rank, user: user, event: event) }

    # context 'chooses an event', js: true do

    #   it "attends from a list of events" do
    #     visit root_path
    #     click_link 'Connect with Facebook'
    #     click_on 'Events'
    #     binding.pry
    #     first('.attend').click
    #     expect(page).to have_content 'You are attending this event'
    #   end

      # it 'attends a paid event' do
      #   visit root_path
      #   click_link 'Connect with Facebook'
      #   click_on 'EVENTS'
      #   click_on 'PaidCityCamp'
      #   click_on 'Attend'
      #   fill_in 'Card number', with: '1'
      #   fill_in 'Card Verification Value (CVV)', with: '123'
      #   fill_in 'Address line 1', with: '123 N Park St.'
      #   fill_in 'City', with: 'Madison'
      #   fill_in 'State', with: 'WI'
      #   fill_in 'Zip code', with: '11111'
      #   click_on 'Save'
      #   expect(page).to have_content event.title
      #   expect(page).to have_content 'Attending'
      #   expect(page).to have_content 'Your payment was successful'
      # end

      # it 'fails a payment registering for an event' do
      #   visit root_path
      #   click_link 'Connect with Facebook'
      #   click_on 'EVENTS'
      #   click_on 'PaidCityCamp'
      #   click_on 'Attend'
      #   fill_in 'Card number', with: '2'
      #   fill_in 'Card Verification Value (CVV)', with: '123'
      #   fill_in 'Address line 1', with: '123 N Park St.'
      #   fill_in 'City', with: 'Madison'
      #   fill_in 'State', with: 'WI'
      #   fill_in 'Zip code', with: '11111'
      #   click_on 'Save'
      #   expect(page).to have_content event.title
      #   expect(page).to have_content 'Attend'
      #   expect(page).to have_content 'There was a billing error!'
      # end
    # end
  end
end
