require 'spec_helper'

describe 'an existing user' do
  let(:name) { OmniAuth.config.mock_auth[:default].info.name }

  context 'signed in with facebook' do
    before do
      visit root_path
      click_link 'Connect with Facebook'
    end

    it 'signs out the user' do
      visit '/logout'
      expect(page).to have_content('Signed out!')
    end

    it 'does not disconnect the account' do
      find('.facebook .disconnect').click
      expect(page).to have_content('You cannot disconnect if you are only connected to one social account')
    end
  end

  context 'signed in with facebook and twitter' do
    before do
      visit root_path
      click_link 'Connect with Facebook'
      click_link 'Connect with Twitter'
    end

    it 'signs out the user' do
      find('.facebook .disconnect').click
      expect(page).to have_content('We have deleted your')
      expect(page.find('.facebook')).to_not have_content(name)
    end
  end
end
