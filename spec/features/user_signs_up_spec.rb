require 'spec_helper'

describe "A user signs up" do
  let(:uid) { OmniAuth.config.mock_auth[provider.intern]['uid'] }

  context 'with facebook' do
    let(:provider) { 'facebook' }
    let(:email) { OmniAuth.config.mock_auth[provider.intern]['info']['email'] }

    it "authorizes" do
      visit root_path
      click_link 'Sign up with Facebook'
      expect(page).to have_content(email)
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
    end
  end

  context 'with twitter' do
    let(:provider) { 'twitter' }

    it "authorizes" do
      visit root_path
      click_link 'Sign up with Twitter'
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
    end
  end

end