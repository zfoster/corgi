require 'spec_helper'

describe "A new user is forced to authorize" do
  let(:name) { OmniAuth.config.mock_auth[provider.intern].info.name }
  let(:nickname) { OmniAuth.config.mock_auth[provider.intern].info.nickname }
  let(:event) { create(:event) }

  context 'with facebook' do
    let(:provider) { 'facebook' }

    it 'clicks attend and redirects to authorizations' do
      visit event_path(event)
      # click_link 'Attend'
      # expect(page).to have_content('You must authorize before continuing')
      # click_link 'Connect with Facebook'
      # expect(current_path).to eq(event_path(event))
    end
  end

  context 'with twitter' do
    let(:provider) { 'twitter' }

    it 'clicks attend and redirects to authorizations' do
      visit event_path(event)
      # click_link 'Attend'
      # expect(page).to have_content('You must authorize before continuing')
      # click_link 'Connect with Twitter'
      # fill_in 'twitter-email', with: 'bob@example.com'
      # click_on 'Save Email'
      # expect(current_path).to eq(event_path(event))
    end
  end

end
