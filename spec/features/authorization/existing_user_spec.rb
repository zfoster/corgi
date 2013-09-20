require 'spec_helper'

describe 'an existing user' do
  let(:uid) { '12345' }

  context 'signed in with facebook' do
    let(:provider) { 'facebook' }
    let(:email) { 'bob@example.com' }

    it 'signs out' do
      visit root_path
      click_link 'Sign up with Facebook'
      expect(page).to have_content(email)
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
      visit root_path
      click_link 'Sign Out'
      expect(page).to have_content('Signed out!')
    end
  end
end
