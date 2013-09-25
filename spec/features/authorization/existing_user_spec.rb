require 'spec_helper'

describe 'an existing user' do
  let(:uid) { '12345' }

  context 'signed in with facebook' do
    let(:provider) { 'facebook' }
    let(:email) { 'bob@example.com' }

    it 'signs out' do
      visit root_path
      click_link 'Connect with Facebook'
      expect(page).to have_content(email)
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
      visit root_path
      visit '/logout'
      expect(page).to have_content('Signed out!')
    end

    it 'updates their email from home page' do
      visit root_path
      click_link 'Connect with Facebook'
      expect(page).to have_content(email)
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
      visit root_path
      fill_in 'Email Address', with: 'notbob@example.com'
      click_on 'Update Email'
      expect(page).to have_content('notbob@example.com')
    end

    content 'from users#show page' do

      it 'chooses an existing email' do
        visit root_path
        click_link 'Connect with Facebook'
        expect(page).to have_content(email)
        expect(page).to have_content(provider)
        expect(page).to have_content(uid)
      end
    end
  end
end
