require 'spec_helper'

describe 'an existing user' do
  let(:uid) { '12345' }

  context 'signed in with facebook' do
    it 'signs out' do
      visit root_path
      click_link 'Connect with Facebook'
      visit root_path
      visit '/logout'
      expect(page).to have_content('Signed out!')
    end
  end
end
